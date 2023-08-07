/*
 * SPDX-FileCopyrightText: Copyright © 2023 Serpent OS Developers
 *
 * SPDX-License-Identifier: Zlib
 */

/**
 * packagekit.backend.lookup
 *
 * Lookup (resolve/providers) APIs for the PackageKit backend
 *
 * Authors: Copyright © 2023 Serpent OS Developers
 * License: Zlib
 */

module packagekit.backend.lookup;

import packagekit.backend : PkBackend;
import packagekit.job;
import packagekit.bitfield;
import packagekit.enums;

export extern (C)
{
    void pk_backend_resolve(PkBackend* backend, PkBackendJob* job,
            PkBitfield filters, char** packageIDS)
    {
        BackendJob(job).finished;
    }

    void pk_backend_what_provides(PkBackend* backend, PkBackendJob* job,
            PkBitfield filters, char** values)
    {
        BackendJob(job).status(PkStatusEnum.PK_STATUS_ENUM_QUERY).finished;

    }
}
