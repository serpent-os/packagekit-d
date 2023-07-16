/*
 * SPDX-FileCopyrightText: Copyright © 2023 Serpent OS Developers
 *
 * SPDX-License-Identifier: Zlib
 */

/**
 * packagekit.backend.repos
 *
 * Repo APIs for the PackageKit backend
 *
 * Authors: Copyright © 2023 Serpent OS Developers
 * License: Zlib
 */

module packagekit.backend.repos;

import packagekit.backend : PkBackend;
import packagekit.job;
import packagekit.bitfield;
import packagekit.enums;

export extern (C)
{
    void pk_backend_get_repo_list(PkBackend* backend, PkBackendJob* job, PkBitfield filters)
    {
        pk_backend_job_set_status(job, PkStatusEnum.PK_STATUS_ENUM_REQUEST);
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
}
