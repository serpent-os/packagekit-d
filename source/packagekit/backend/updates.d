/*
 * SPDX-FileCopyrightText: Copyright © 2023 Serpent OS Developers
 *
 * SPDX-License-Identifier: Zlib
 */

/**
 * packagekit.backend.updates
 *
 * Update APIs for the PackageKit backend
 *
 * Authors: Copyright © 2023 Serpent OS Developers
 * License: Zlib
 */

module packagekit.backend.updates;

import packagekit.backend : PkBackend;
import packagekit.job;
import packagekit.bitfield;
import packagekit.enums;

export extern (C)
{

    void pk_backend_get_distro_upgrades(PkBackend* backend, PkBackendJob* job)
    {
        pk_backend_job_set_status(job, PkStatusEnum.PK_STATUS_ENUM_QUERY);
        pk_backend_job_finished(job);
    }

    void pk_backend_get_update_detail(PkBackend* backend, PkBackendJob* job, char** packageIDs)
    {
        pk_backend_job_set_status(job, PkStatusEnum.PK_STATUS_ENUM_REQUEST);
        pk_backend_job_finished(job);
    }

    void pk_backend_get_updates(PkBackend* backend, PkBackendJob* job, PkBitfield filters)
    {
        pk_backend_job_set_status(job, PkStatusEnum.PK_STATUS_ENUM_REQUEST);
        pk_backend_job_finished(job);
    }

    void pk_backend_update_packages(PkBackend* backend, PkBackendJob* job,
            PkBitfield transactionFlags, char** packageIDS)
    {
        pk_backend_job_finished(job);
    }

    void pk_backend_upgrade_system(PkBackend* backend, PkBackendJob* job,
            PkBitfield transactionFlags, const(char*) distroID, PkUpgradeKindEnum upgradeKind)
    {
        pk_backend_job_set_status(job, PkStatusEnum.PK_STATUS_ENUM_DOWNLOAD);
        pk_backend_job_finished(job);
    }

}
