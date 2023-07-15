/*
 * SPDX-FileCopyrightText: Copyright © 2023 Ikey Doherty
 *
 * SPDX-License-Identifier: Zlib
 */

/**
 * packagekit.backend.jobs
 *
 * Job APIs for the PackageKit backend
 *
 * Authors: Copyright © 2023 Ikey Doherty
 * License: Zlib
 */

module packagekit.backend.jobs;

import packagekit.backend : PkBackend;
import packagekit.job;

export extern (C)
{
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
}
