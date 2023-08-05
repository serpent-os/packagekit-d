/*
 * SPDX-FileCopyrightText: Copyright © 2023 Serpent OS Developers
 *
 * SPDX-License-Identifier: Zlib
 */

/**
 * packagekit.forkworker
 *
 * Provides simple APIs to run a function under fork() child process,
 * and RAII semantics to ensure the process quits before stack unwind.
 *
 * This is more useful for plugins relying on heavy backends, or the GC,
 * to ensure the cost is eliminated when the child process exits.
 *
 * Authors: Copyright © 2023 Serpent OS Developers
 * License: Zlib
 */

module packagekit.forkworker;

@safe:

import std.typecons : safeRefCounted;
import core.sys.posix.unistd : fork;
import cwait = core.sys.posix.sys.wait;
import std.exception : errnoEnforce, ifThrown;
import core.stdc.stdlib : _Exit;
import std.traits : ReturnType;

/**
 * Private implementation to encapsulate a fork()ed function call.
 *
 * Params:
 *  FunctionType = Functions type
 */
package struct ForkWorker(FunctionType) if (is(ReturnType!FunctionType == int))
{
    @disable this();
    @disable this(this);

    /** 
     * Construct a new ForkWorker
     *
     * Params:
     *   e = Function executor
     */
    package this(FunctionType e) nothrow @nogc
    {
        this.executor = e;
    }

    ~this()
    {
        wait();
    }

    /** 
     * Run fork + function in child
     *
     * Params:
     *   args = Arguments to call the function with, under fork conditions
     * Returns: Reference to this.
     * Throws: ErrnoException if fork failed.
     */
    package void run(Args...)(auto ref Args args)
    {
        forkPid = fork();
        errnoEnforce(forkPid >= 0);

        if (forkPid != 0)
            return;

        /* In the child process.. */
        int ret;

        () @trusted { ret = executor(args).ifThrown(0); _Exit(ret); }();
    }

    /** 
     * Forcibly await completion of the process
     */
    auto wait() @trusted
    {
        if (forkPid < 0)
        {
            return -1;
        }

        scope (exit)
        {
            forkPid = -1;
        }

        int status;

        cwait.pid_t waiter;
        do
        {
            waiter = cwait.waitpid(forkPid, &status, cwait.WUNTRACED | cwait.WCONTINUED);
            errnoEnforce(waiter >= 0);
        }
        while (!cwait.WIFEXITED(status) && !cwait.WIFSIGNALED(status));
        return cwait.WEXITSTATUS(status);
    }

private:
    FunctionType executor;
    cwait.pid_t forkPid = -1;
}

/**
 * Run a function with the given args under fork()
 *
 * Params;
 *  FunctionType = Type of the function being called
 *  Args = Argument type sequence
 *  functor = Function to execute
 *  args = argument to pass to the function
 */
auto runForked(FunctionType, Args...)(FunctionType functor, auto ref Args args) @trusted
{
    auto worker = ForkWorker!(FunctionType)(functor).safeRefCounted;
    worker.run!Args(args);
    return worker;
}
