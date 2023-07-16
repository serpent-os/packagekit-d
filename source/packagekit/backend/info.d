/*
 * SPDX-FileCopyrightText: Copyright © 2023 Serpent OS Developers
 *
 * SPDX-License-Identifier: Zlib
 */

/**
 * packagekit.backend.info
 *
 * Package info APIs for the PackageKit backend
 *
 * Authors: Copyright © 2023 Serpent OS Developers
 * License: Zlib
 */

module packagekit.backend.info;

import packagekit.backend : PkBackend;
import packagekit.job;
import packagekit.enums;

export extern (C)
{
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
}
