/*
 * SPDX-FileCopyrightText: Copyright © 2023 Ikey Doherty
 *
 * SPDX-License-Identifier: Zlib
 */

/**
 * packagekit.backend
 *
 * PackageKit plugin for deopkg API
 * Exposes a C API to match https://github.com/PackageKit/PackageKit/blob/main/src/pk-backend.c#L494
 *
 * This module is split across multiple files to make the implementation simpler and group by logical
 * functionality.
 *
 * Authors: Copyright © 2023 Ikey Doherty
 * License: Zlib
 */

module packagekit.backend;

@safe:

import pyd.pyd;
import pyd.embedded;
import glib.c.types : GKeyFile;
import glib.c.functions : g_strdupv, g_strv_length;

import std.stdint : uint64_t;
import packagekit.job;
import packagekit.bitfield;
import packagekit.enums;

private static immutable char*[] mimeTypes = [null];

public import packagekit.backend.deps;
public import packagekit.backend.files;
public import packagekit.backend.install;
public import packagekit.backend.jobs;
public import packagekit.backend.remove;
public import packagekit.backend.repos;
public import packagekit.backend.search;
public import packagekit.backend.updates;

export extern (C)
{
    struct PkBackend;

    /** 
     * Params:
     *   self = Current backend
     * Returns: backend author
     */
    const(char*) pk_backend_get_author(PkBackend* self) => "Ikey Doherty";

    /** 
     * Params:
     *   self = Current backend
     * Returns: backend name
     */
    const(char*) pk_backend_get_name(PkBackend* self) => "deopkg";

    /** 
     * Params:
     *   self = Current backend
     * Returns: backend description
     */
    const(char*) pk_backend_get_description(PkBackend* self) => "eopkg support";

    /** 
     * Initialise the backend
     *
     * Params:
     *   config = PackageKit's configuration file
     *   self = Current backend
     */
    void pk_backend_initialize(GKeyFile* config, PkBackend* self) @trusted
    {
        imported!"core.stdc.stdio".puts("[deopkg] Init\n");
        on_py_init({ add_module!(ModuleName!"deopkg"); });
        py_init();

        // Prove that we can "get" packages
        import std.algorithm : each;
        import std.stdio : writeln;

        alias py_def!(import("getPackages.py"), "deopkg", string[]function()) getPackages;
        getPackages.each!writeln;
    }

    /** 
     * Destroy the backend
     *
     * Params:  
     *   self = Current backend
     */
    void pk_backend_destroy(PkBackend* self) @trusted
    {
        imported!"core.stdc.stdio".puts("[deopkg] Destroy\n");
        py_finish();
    }

    PkBitfield pk_backend_get_groups(PkBackend* self) => 0;
    PkBitfield pk_backend_get_roles(PkBackend* self) => 0;
    PkBitfield pk_backend_get_filters(PkBackend* self)
    {
        with (PkFilterEnum)
        {
            return pk_bitfield_from_enums(PK_FILTER_ENUM_DEVELOPMENT,
                    PK_FILTER_ENUM_GUI, PK_FILTER_ENUM_INSTALLED,);
        }
    }

    PkBitfield pk_backend_get_provides(PkBackend* self) => 0;

    /** 
     * Params:
     *   self = Current backend
     * Returns: An allocated copy of supported mimetypes
     */
    char** pk_backend_get_mime_types(PkBackend* self) @trusted => (cast(char**) mimeTypes.ptr)
        .g_strdupv;

    bool pk_backend_supports_parallelization(PkBackend* self) => false;

    void pk_backend_download_packages(PkBackend* self, PkBackendJob* job,
            char** packageIDs, const(char*) dir)
    {
        pk_backend_job_set_status(job, PkStatusEnum.PK_STATUS_ENUM_DOWNLOAD);
        pk_backend_job_finished(job);
    }

    void pk_backend_get_categories(PkBackend* backend, PkBackendJob* job)
    {
        pk_backend_job_finished(job);
    }

    void pk_backend_get_details(PkBackend* backend, PkBackendJob* job, char** packageIDs)
    {
        pk_backend_job_set_status(job, PkStatusEnum.PK_STATUS_ENUM_QUERY);
        pk_backend_job_finished(job);
    }

    void pk_backend_get_details_local(PkBackend* backend, PkBackendJob* job, char** packageIDs)
    {
        pk_backend_job_set_status(job, PkStatusEnum.PK_STATUS_ENUM_QUERY);
        pk_backend_job_finished(job);
    }

    void pk_backend_get_packages(PkBackend* backend, PkBackendJob* job, PkBitfield filters)
    {
        pk_backend_job_set_status(job, PkStatusEnum.PK_STATUS_ENUM_REQUEST);
        pk_backend_job_finished(job);
    }

    void pk_backend_refresh_cache(PkBackend* backend, PkBackendJob* job, bool force)
    {
        pk_backend_job_set_status(job, PkStatusEnum.PK_STATUS_ENUM_REFRESH_CACHE);
        pk_backend_job_finished(job);
    }

    void pk_backend_resolve(PkBackend* backend, PkBackendJob* job,
            PkBitfield filters, char** packageIDS)
    {
        pk_backend_job_finished(job);
    }

    void pk_backend_what_provides(PkBackend* backend, PkBackendJob* job,
            PkBitfield filters, char** values)
    {
        pk_backend_job_set_status(job, PkStatusEnum.PK_STATUS_ENUM_REQUEST);
        pk_backend_job_finished(job);
    }

    void pk_backend_repair_system(PkBackend* backend, PkBackendJob* job,
            PkBitfield transactionFlags)
    {
        pk_backend_job_finished(job);
    }
}
