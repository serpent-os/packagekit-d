/*
 * SPDX-FileCopyrightText: Copyright © 2023 Serpent OS Developers
 *
 * SPDX-License-Identifier: Zlib
 */

/**
 * packagekit.backend.deps
 *
 * Dependency APIs for the PackageKit backend
 *
 * Authors: Copyright © 2023 Serpent OS Developers
 * License: Zlib
 */

module packagekit.backend.deps;

import packagekit.backend : PkBackend;
import packagekit.job;
import packagekit.bitfield;
import packagekit.enums;

export extern (C)
{
    void pk_backend_required_by(PkBackend* backend, PkBackendJob* job,
            PkBitfield filters, char** packageIDs, bool recursive)
    {
        BackendJob(job).finished;
    }

    void pk_backend_depends_on(PkBackend* backend, PkBackendJob* job,
            PkBitfield filters, char** packageIDs, bool recursive)
    {
        BackendJob(job).status(PkStatusEnum.PK_STATUS_ENUM_QUERY).finished;
    }
}
