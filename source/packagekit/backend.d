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

import pyd.pyd;
import pyd.embedded;

// negatively impacts build time
//import glib.c.types : GKeyFile;
alias GKeyFile = void;

import std.stdint : uint64_t;

// TODO: Incorporate these properly
alias PkBitfield = uint64_t;
enum PkSigTypeEnum
{
    start
}

enum PkUpgradeKindEnum
{
    start
}

export extern (C)
{
    struct PkBackend;
    struct PkBackendJob;

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
    void pk_backend_initialize(GKeyFile* config, PkBackend* self)
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
    void pk_backend_destroy(PkBackend* self)
    {
        imported!"core.stdc.stdio".puts("[deopkg] Destroy\n");
        py_finish();
    }

    PkBitfield pk_backend_get_groups(PkBackend* self) => 0;
    PkBitfield pk_backend_get_filters(PkBackend* self) => 0;
    PkBitfield pk_backend_get_roles(PkBackend* self) => 0;
    PkBitfield pk_backend_get_provides(PkBackend* self) => 0;
    char** pk_backend_get_mime_types(PkBackend* self) => null;
    bool pk_backend_supports_parallelization(PkBackend* self) => false;
    void pk_backend_job_start(PkBackend* self, PkBackendJob* job)
    {
    }

    void pk_backend_job_stop(PkBackend* self, PkBackendJob* job)
    {
    }

    void pk_backend_cancel(PkBackend* self, PkBackendJob* job)
    {
    }

    void pk_backend_download_packages(PkBackend* self, PkBackendJob* job,
            char** packageIDs, const(char*) dir)
    {
    }

    void pk_backend_get_categories(PkBackend* backend, PkBackendJob* job)
    {
    }

    void pk_backend_depends_on(PkBackend* backend, PkBackendJob* job,
            PkBitfield filters, char** packageIDs, bool recursive)
    {
    }

    void pk_backend_get_details(PkBackend* backend, PkBackendJob* job, char** packageIDs)
    {
    }

    void pk_backend_get_details_local(PkBackend* backend, PkBackendJob* job, char** packageIDs)
    {
    }

    void pk_backend_get_files_local(PkBackend* backend, PkBackendJob* job, char** files)
    {
    }

    void pk_backend_get_distro_upgrades(PkBackend* backend, PkBackendJob* job);
    void pk_backend_get_files(PkBackend* backend, PkBackendJob* job, char** files)
    {
    }

    void pk_backend_get_packages(PkBackend* backend, PkBackendJob* job, PkBitfield filters)
    {
    }

    void pk_backend_get_repo_list(PkBackend* backend, PkBackendJob* job, PkBitfield filters)
    {
    }

    void pk_backend_required_by(PkBackend* backend, PkBackendJob* job,
            PkBitfield filters, char** packageIDs, bool recursive)
    {
    }

    void pk_backend_get_update_detail(PkBackend* backend, PkBackendJob* job, char** packageIDs)
    {
    }

    void pk_backend_get_updates(PkBackend* backend, PkBackendJob* job, PkBitfield filters)
    {
    }

    void pk_backend_install_files(PkBackend* backend, PkBackendJob* job,
            PkBitfield transactionFlags)
    {
    }

    void pk_backend_install_packages(PkBackend* backend, PkBackendJob* job,
            PkBitfield transactionFlags, char** packageIDs)
    {
    }

    void pk_backend_install_signature(PkBackend* backend, PkBackendJob* job,
            PkSigTypeEnum type, const(char*) keyID, const(char*) packageID)
    {
    }

    void pk_backend_refresh_cache(PkBackend* backend, PkBackendJob* job, bool force);
    void pk_backend_remove_packages(PkBackend* backend, PkBackendJob* job,
            PkBitfield transactionFlags, char** packageIDs, bool allowDeps, bool autoRemove)
    {
    }

    void pk_backend_repo_enable(PkBackend* backend, PkBackendJob* job,
            const(char*) repoID, bool enabled)
    {
    }

    void pk_backend_repo_set_data(PkBackend* backend, PkBackendJob* job,
            const(char*) repoID, const(char*) key, const(char*) val)
    {
    }

    void pk_backend_repo_remove(PkBackend* backend, PkBackendJob* job,
            PkBitfield transactionFlags, const(char*) repoID, bool autoRemove)
    {
    }

    void pk_backend_resolve(PkBackend* backend, PkBackendJob* job,
            PkBitfield filters, char** packageIDS)
    {
    }

    void pk_backend_search_details(PkBackend* backend, PkBackendJob* job,
            PkBitfield filters, char** values)
    {
    }

    void pk_backend_search_files(PkBackend* backend, PkBackendJob* job,
            PkBitfield filters, char** values)
    {
    }

    void pk_backend_search_groups(PkBackend* backend, PkBackendJob* job,
            PkBitfield filters, char** values)
    {
    }

    void pk_backend_search_names(PkBackend* backend, PkBackendJob* job,
            PkBitfield filters, char** values)
    {
    }

    void pk_backend_update_packages(PkBackend* backend, PkBackendJob* job,
            PkBitfield transactionFlags, char** packageIDS)
    {
    }

    void pk_backend_what_provides(PkBackend* backend, PkBackendJob* job,
            PkBitfield filters, char** values)
    {
    }

    void pk_backend_upgrade_system(PkBackend* backend, PkBackendJob* job,
            PkBitfield transactionFlags, const(char*) distroID, PkUpgradeKindEnum upgradeKind)
    {
    }

    void pk_backend_repair_system(PkBackend* backend, PkBackendJob* job,
            PkBitfield transactionFlags)
    {
    }
}
