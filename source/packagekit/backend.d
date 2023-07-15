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
 * Authors: Copyright © 2023 Ikey Doherty
 * License: Zlib
 */

module packagekit.backend;

@safe:

import pyd.pyd;
import pyd.embedded;
import glib.c.types : GKeyFile;
import glib.c.functions : g_strdupv;

import std.stdint : uint64_t;
import packagekit.job;
import packagekit.bitfield;

// TODO: Incorporate these properly
enum PkSigTypeEnum
{
    start
}

enum PkUpgradeKindEnum
{
    start
}

private static immutable char*[] mimeTypes = [null];

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
        py_init();
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
    PkBitfield pk_backend_get_filters(PkBackend* self) => 0;
    PkBitfield pk_backend_get_roles(PkBackend* self) => 0;
    PkBitfield pk_backend_get_provides(PkBackend* self) => 0;

    /** 
     * 
     * Params:
     *   self = Current backend
     * Returns: An allocated copy of supported mimetypes
     */
    char** pk_backend_get_mime_types(PkBackend* self) @trusted => (cast(char**) mimeTypes.ptr)
        .g_strdupv;

    bool pk_backend_supports_parallelization(PkBackend* self) => false;
    void pk_backend_job_start(PkBackend* self, PkBackendJob* job)
    {
        pk_backend_job_finished(job);
    }

    void pk_backend_job_stop(PkBackend* self, PkBackendJob* job)
    {
        pk_backend_job_finished(job);
    }

    void pk_backend_cancel(PkBackend* self, PkBackendJob* job)
    {
        pk_backend_job_finished(job);
    }

    void pk_backend_download_packages(PkBackend* self, PkBackendJob* job,
            char** packageIDs, const(char*) dir)
    {
        pk_backend_job_finished(job);
    }

    void pk_backend_get_categories(PkBackend* backend, PkBackendJob* job)
    {
        pk_backend_job_finished(job);
    }

    void pk_backend_depends_on(PkBackend* backend, PkBackendJob* job,
            PkBitfield filters, char** packageIDs, bool recursive)
    {
        pk_backend_job_finished(job);
    }

    void pk_backend_get_details(PkBackend* backend, PkBackendJob* job, char** packageIDs)
    {
        pk_backend_job_finished(job);
    }

    void pk_backend_get_details_local(PkBackend* backend, PkBackendJob* job, char** packageIDs)
    {
        pk_backend_job_finished(job);
    }

    void pk_backend_get_files_local(PkBackend* backend, PkBackendJob* job, char** files)
    {
        pk_backend_job_finished(job);
    }

    void pk_backend_get_distro_upgrades(PkBackend* backend, PkBackendJob* job)
    {
        pk_backend_job_finished(job);
    }

    void pk_backend_get_files(PkBackend* backend, PkBackendJob* job, char** files)
    {
        pk_backend_job_finished(job);
    }

    void pk_backend_get_packages(PkBackend* backend, PkBackendJob* job, PkBitfield filters) @trusted
    {
        pk_backend_job_finished(job);
    }

    void pk_backend_get_repo_list(PkBackend* backend, PkBackendJob* job, PkBitfield filters)
    {
        pk_backend_job_finished(job);
    }

    void pk_backend_required_by(PkBackend* backend, PkBackendJob* job,
            PkBitfield filters, char** packageIDs, bool recursive)
    {
        pk_backend_job_finished(job);
    }

    void pk_backend_get_update_detail(PkBackend* backend, PkBackendJob* job, char** packageIDs)
    {
        pk_backend_job_finished(job);
    }

    void pk_backend_get_updates(PkBackend* backend, PkBackendJob* job, PkBitfield filters)
    {
        pk_backend_job_finished(job);
    }

    void pk_backend_install_files(PkBackend* backend, PkBackendJob* job,
            PkBitfield transactionFlags)
    {
        pk_backend_job_finished(job);
    }

    void pk_backend_install_packages(PkBackend* backend, PkBackendJob* job,
            PkBitfield transactionFlags, char** packageIDs)
    {
        pk_backend_job_finished(job);
    }

    void pk_backend_install_signature(PkBackend* backend, PkBackendJob* job,
            PkSigTypeEnum type, const(char*) keyID, const(char*) packageID)
    {
        pk_backend_job_finished(job);
    }

    void pk_backend_refresh_cache(PkBackend* backend, PkBackendJob* job, bool force)
    {
        pk_backend_job_finished(job);
    }

    void pk_backend_remove_packages(PkBackend* backend, PkBackendJob* job,
            PkBitfield transactionFlags, char** packageIDs, bool allowDeps, bool autoRemove)
    {
        pk_backend_job_finished(job);
    }

    void pk_backend_repo_enable(PkBackend* backend, PkBackendJob* job,
            const(char*) repoID, bool enabled)
    {
        pk_backend_job_finished(job);
    }

    void pk_backend_repo_set_data(PkBackend* backend, PkBackendJob* job,
            const(char*) repoID, const(char*) key, const(char*) val)
    {
        pk_backend_job_finished(job);
    }

    void pk_backend_repo_remove(PkBackend* backend, PkBackendJob* job,
            PkBitfield transactionFlags, const(char*) repoID, bool autoRemove)
    {
        pk_backend_job_finished(job);
    }

    void pk_backend_resolve(PkBackend* backend, PkBackendJob* job,
            PkBitfield filters, char** packageIDS)
    {
        pk_backend_job_finished(job);
    }

    void pk_backend_search_details(PkBackend* backend, PkBackendJob* job,
            PkBitfield filters, char** values)
    {
        pk_backend_job_finished(job);
    }

    void pk_backend_search_files(PkBackend* backend, PkBackendJob* job,
            PkBitfield filters, char** values)
    {
        pk_backend_job_finished(job);
    }

    void pk_backend_search_groups(PkBackend* backend, PkBackendJob* job,
            PkBitfield filters, char** values)
    {
        pk_backend_job_finished(job);
    }

    void pk_backend_search_names(PkBackend* backend, PkBackendJob* job,
            PkBitfield filters, char** values)
    {
        pk_backend_job_finished(job);
    }

    void pk_backend_update_packages(PkBackend* backend, PkBackendJob* job,
            PkBitfield transactionFlags, char** packageIDS)
    {
        pk_backend_job_finished(job);
    }

    void pk_backend_what_provides(PkBackend* backend, PkBackendJob* job,
            PkBitfield filters, char** values)
    {
        pk_backend_job_finished(job);
    }

    void pk_backend_upgrade_system(PkBackend* backend, PkBackendJob* job,
            PkBitfield transactionFlags, const(char*) distroID, PkUpgradeKindEnum upgradeKind)
    {
        pk_backend_job_finished(job);
    }

    void pk_backend_repair_system(PkBackend* backend, PkBackendJob* job,
            PkBitfield transactionFlags)
    {
        pk_backend_job_finished(job);
    }
}
