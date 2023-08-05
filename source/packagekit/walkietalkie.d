/*
 * SPDX-FileCopyrightText: Copyright © 2023 Serpent OS Developers
 *
 * SPDX-License-Identifier: Zlib
 */

/**
 * packagekit.walkietalkie
 *
 * A simplistic wrapper around `socketpair()` ensuring `@nogc` usage.
 * This allows plugins with expensive backends to perform GC-intensive
 * work in a fork and eliminate the cost in the main process.
 *
 * Authors: Copyright © 2023 Serpent OS Developers
 * License: Zlib
 */

module packagekit.walkietalkie;

@safe:

import std.exception : errnoEnforce;
import unistd = core.sys.posix.unistd;
import core.sys.posix.sys.socket : socketpair, AF_UNIX, SOCK_STREAM, recv, shutdown, SHUT_RDWR;

private enum readBufferSize = 2 << 14;

/** 
 * A WalkieTalkie is a silly wrapper around `socketpair()`
 * to provide an idiomatic API while avoiding the penalty
 * of the Garbage Collector for a long running process.
 *
 * We always write to the first file descriptor, reading from the 2nd.
 */
public struct WalkieTalkie
{
    @disable this();
    @disable this(this);

    ~this() @nogc nothrow
    {
        unistd.close(fd[0]);
        unistd.close(fd[1]);
    }

    package this(int[2] fd) @nogc nothrow
    {
        this.fd = fd;
    }

    /** 
     * Write to the stream
     *
     * Params:
     *   buffer = The input buffer to write with
     * Returns: True if the write succeeded. Check `errno` for errors
     */
    bool write(char[] buffer) @trusted @nogc nothrow
    {
        return unistd.write(fd[1], buffer.ptr, buffer.length) == buffer.length;
    }

    /** 
     * Returns: A reader for the walkie talkie. Operates as a chunked range.
     * Should NOT be used from the child process!
     */
    auto reader() @nogc nothrow
    {
        static struct Reader
        {
            int fd;
            char[readBufferSize] fixedBuffer;
            ulong nBytes;

            pure bool empty() @nogc nothrow => nBytes < 1;
            pure auto front() @nogc nothrow => fixedBuffer[0 .. nBytes];
            auto popFront() @nogc nothrow @trusted => nBytes = recv(fd,
                    fixedBuffer.ptr, fixedBuffer.length, 0);

            /* Prime the buffer for range ops */
            auto ref prime() @nogc nothrow
            {
                popFront();
                return this;
            }

        }

        return Reader(fd[0]).prime;
    }

    /**
     * Stop all communications. Used as a flush on the socket.
     *
     * Returns: C status code.
     */
    auto stop() @nogc nothrow => shutdown(fd[1], SHUT_RDWR) == 0;

private:

    int[2] fd;
}

/** 
 * Construct a new WalkieTalkie. Will throw an exception if this fails.
 * Other than that, pure nogc.
 *
 * Returns: Initialised WalkieTalkie used for fork comms
 */
auto walkieTalkie() @trusted
{
    int[2] fd = void;
    errnoEnforce(socketpair(AF_UNIX, SOCK_STREAM, 0, fd) == 0);
    return WalkieTalkie(fd);
}
