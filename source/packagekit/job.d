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

/**
 * Opaque type within packagekit daemon, satisfied with weak linkage
 */
extern (C) struct PkBackendJob;

/** 
 * Notify completion of a job
 * Params:
 *   self = Job
 */
@weak extern (C) void pk_backend_job_finished(PkBackendJob* self) @trusted;

/** 
 * Append a package to the current backend job
 *
 * Params:
 *   self = Job
 *   info = Info enum (Installed/Available/etc)
 *   pkgID = Unique package identifier
 *   summary = Summary of the package
 */
@weak extern (C) void pk_backend_job_package(PkBackendJob* self,
        PkInfoEnum info, const char* pkgID, const char* summary) @trusted;

/** 
 * Populate with a complete set of packages (more efficient)
 *
 * Params:
 *   self = Job
 *   packages = A GPtrArray of PkPackage
 */
@weak extern (C) void pk_backend_job_packages(PkBackendJob* self, GPtrArray* packages) @trusted;

/** 
 * Notify daemon of the job status
 *
 * Params:
 *   job = Job
 *   status = New status for our job
 */
@weak extern (C) void pk_backend_job_set_status(PkBackendJob* job, PkStatusEnum status) @trusted;

/** 
 * Notify daemon of an error with the job
 *
 * Params:
 *   job = Job
 *   code = The error code
 */
@weak extern (C) void pk_backend_job_error_code(PkBackendJob* job, PkErrorEnum code) @trusted;
