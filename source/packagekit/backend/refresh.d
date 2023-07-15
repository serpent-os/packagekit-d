/*
 * SPDX-FileCopyrightText: Copyright © 2023 Ikey Doherty
 *
 * SPDX-License-Identifier: Zlib
 */

/**
 * packagekit.backend.refresh
 *
 * Refresh APIs for the PackageKit backend
 *
 * Authors: Copyright © 2023 Ikey Doherty
 * License: Zlib
 */

module packagekit.backend.refresh;

import packagekit.backend : PkBackend;
import packagekit.job;
import packagekit.enums;

export extern (C)
{
    void pk_backend_refresh_cache(PkBackend* backend, PkBackendJob* job, bool force)
    {
        pk_backend_job_set_status(job, PkStatusEnum.PK_STATUS_ENUM_REFRESH_CACHE);
        pk_backend_job_finished(job);
    }
}
