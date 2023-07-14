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

import glib.c.types : GKeyFile;
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

    void initialize(GKeyFile* config, PkBackend* self)
    {
    }

    void destroy(PkBackend* self)
    {
    }

    PkBitfield get_groups(PkBackend* self) => 0;
    PkBitfield get_filters(PkBackend* self) => 0;
    PkBitfield get_roles(PkBackend* self) => 0;
    PkBitfield get_provides(PkBackend* self) => 0;
    char** get_mime_types(PkBackend* self) => null;
    bool supports_parallelization(PkBackend* self) => false;
    void job_start(PkBackend* self, PkBackendJob* job)
    {
    }

    void job_stop(PkBackend* self, PkBackendJob* job)
    {
    }

    void cancel(PkBackend* self, PkBackendJob* job)
    {
    }

    void download_packages(PkBackend* self, PkBackendJob* job, char** packageIDs, const char* dir)
    {
    }

    void get_categories(PkBackend* backend, PkBackendJob* job)
    {
    }

    void depends_on(PkBackend* backend, PkBackendJob* job, PkBitfield filters,
            char** packageIDs, bool recursive)
    {
    }

    void get_details(PkBackend* backend, PkBackendJob* job, char** packageIDs)
    {
    }

    void get_details_local(PkBackend* backend, PkBackendJob* job, char** packageIDs)
    {
    }

    void get_files_local(PkBackend* backend, PkBackendJob* job, char** files)
    {
    }

    void get_distro_upgrades(PkBackend* backend, PkBackendJob* job);
    void get_files(PkBackend* backend, PkBackendJob* job, char** files)
    {
    }

    void get_packages(PkBackend* backend, PkBackendJob* job, PkBitfield filters)
    {
    }

    void get_repo_list(PkBackend* backend, PkBackendJob* job, PkBitfield filters)
    {
    }

    void required_by(PkBackend* backend, PkBackendJob* job, PkBitfield filters,
            char** packageIDs, bool recursive)
    {
    }

    void get_update_detail(PkBackend* backend, PkBackendJob* job, char** packageIDs)
    {
    }

    void get_updates(PkBackend* backend, PkBackendJob* job, PkBitfield filters)
    {
    }

    void install_files(PkBackend* backend, PkBackendJob* job, PkBitfield transactionFlags)
    {
    }

    void install_packages(PkBackend* backend, PkBackendJob* job,
            PkBitfield transactionFlags, char** packageIDs)
    {
    }

    void install_signature(PkBackend* backend, PkBackendJob* job,
            PkSigTypeEnum type, const char* keyID, const char* packageID)
    {
    }

    void refresh_cache(PkBackend* backend, PkBackendJob* job, bool force);
    void remove_packages(PkBackend* backend, PkBackendJob* job,
            PkBitfield transactionFlags, char** packageIDs, bool allowDeps, bool autoRemove)
    {
    }

    void repo_enable(PkBackend* backend, PkBackendJob* job, const char* repoID, bool enabled)
    {
    }

    void repo_set_data(PkBackend* backend, PkBackendJob* job,
            const char* repoID, const char* key, const char* val)
    {
    }

    void repo_remove(PkBackend* backend, PkBackendJob* job,
            PkBitfield transactionFlags, const char* repoID, bool autoRemove)
    {
    }

    void resolve(PkBackend* backend, PkBackendJob* job, PkBitfield filters, char** packageIDS)
    {
    }

    void search_details(PkBackend* backend, PkBackendJob* job, PkBitfield filters, char** values)
    {
    }

    void search_files(PkBackend* backend, PkBackendJob* job, PkBitfield filters, char** values)
    {
    }

    void search_groups(PkBackend* backend, PkBackendJob* job, PkBitfield filters, char** values)
    {
    }

    void search_names(PkBackend* backend, PkBackendJob* job, PkBitfield filters, char** values)
    {
    }

    void update_packages(PkBackend* backend, PkBackendJob* job,
            PkBitfield transactionFlags, char** packageIDS)
    {
    }

    void what_provides(PkBackend* backend, PkBackendJob* job, PkBitfield filters, char** values)
    {
    }

    void upgrade_system(PkBackend* backend, PkBackendJob* job,
            PkBitfield transactionFlags, const char* distroID, PkUpgradeKindEnum upgradeKind)
    {
    }

    void repair_system(PkBackend* backend, PkBackendJob* job, PkBitfield transactionFlags)
    {
    }
}
