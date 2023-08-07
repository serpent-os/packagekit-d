/*
 * SPDX-FileCopyrightText: Copyright © 2023 Serpent OS Developers
 *
 * SPDX-License-Identifier: Zlib
 */

/**
 * packagekit.backend.refresh
 *
 * Refresh APIs for the PackageKit backend
 *
 * Authors: Copyright © 2023 Serpent OS Developers
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
        BackendJob(job).status(PkStatusEnum.PK_STATUS_ENUM_REFRESH_CACHE).finished;
    }
}
