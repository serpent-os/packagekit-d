/*
 * SPDX-FileCopyrightText: Copyright © 2023 Serpent OS Developers
 *
 * SPDX-License-Identifier: Zlib
 */

/**
 * packagekit.job
 *
 * Encapsulates PkBackendJob via weak linkage
 *
 * `PkBackendJob` is used for transaction management and query encapsulation within
 * PackageKit. Some API calls in the backend API require populating storage within the
 * daemon, i.e. via `.package` calls
 *
 * Authors: Copyright © 2023 Serpent OS Developers
 * License: Zlib
 */

module packagekit.job;

import packagekit.enums : PkInfoEnum, PkStatusEnum, PkErrorEnum;
import glib.c.types : GPtrArray;

version (LDC)
    import ldc.attributes : weak;
else
    import core.attributes : weak;

import packagekit.pkg;

/**
 * Opaque type within packagekit daemon, satisfied with weak linkage
 */
extern (C) struct PkBackendJob;

/** 
 * Sane encapsulation of a PkBackendJob for idiomatic D API
 */
public struct BackendJob
{
    @disable this();
    @disable this(this);

    invariant ()
    {
        assert(ptr !is null);
    }

    /** 
     * Update the job status
     *
     * Params:
     *   status = New status for this job
     * Returns: Reference to this
     */
    @property ref auto status(PkStatusEnum status) @trusted
    {
        pk_backend_job_set_status(ptr, status);
        return this;
    }

    /** 
     * Notify PackageKit this job is now complete
     *
     * Returns: Reference to this
     */
    ref auto finished() @trusted
    {
        pk_backend_job_finished(ptr);
        return this;
    }

    /** 
     * Add a set of packages to this job report
     *
     * Params:
     *   pkgs = The package list
     */
    void addPackages(scope ref PackageList pkgs) @trusted => pk_backend_job_packages(ptr,
            pkgs.pointer);

    /** 
     * Set the error code for this job
     *
     * Params:
     *   err = New error code
     * Returns: Reference to this
     */
    @property ref auto errorCode(PkErrorEnum err) @trusted
    {
        pk_backend_job_error_code(ptr, err);
        return this;
    }

package:

    this(PkBackendJob* ptr) @safe @nogc nothrow
    {
        this.ptr = ptr;
    }

private:

    PkBackendJob* ptr;
}

private extern (C)
{
    @weak void pk_backend_job_finished(PkBackendJob* self);
    @weak void pk_backend_job_package(PkBackendJob* self, PkInfoEnum info,
            const char* pkgID, const char* summary);
    @weak void pk_backend_job_packages(PkBackendJob* self, GPtrArray* packages);
    @weak void pk_backend_job_set_status(PkBackendJob* job, PkStatusEnum status);
    @weak void pk_backend_job_error_code(PkBackendJob* job, PkErrorEnum code);
}
