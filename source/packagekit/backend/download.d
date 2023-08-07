/*
 * SPDX-FileCopyrightText: Copyright © 2023 Serpent OS Developers
 *
 * SPDX-License-Identifier: Zlib
 */

/**
 * packagekit.backend.download
 *
 * Download APIs for the PackageKit backend
 *
 * Authors: Copyright © 2023 Serpent OS Developers
 * License: Zlib
 */

module packagekit.backend.download;

import packagekit.backend : PkBackend;
import packagekit.job;
import packagekit.enums;

export extern (C)
{
    void pk_backend_download_packages(PkBackend* self, PkBackendJob* job,
            char** packageIDs, const(char*) dir)
    {
        BackendJob(job).status(PkStatusEnum.PK_STATUS_ENUM_DOWNLOAD).finished;
    }
}
