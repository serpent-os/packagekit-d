/*
 * SPDX-FileCopyrightText: Copyright © 2023 Serpent OS Developers
 *
 * SPDX-License-Identifier: Zlib
 */

/**
 * packagekit.backend.remove
 *
 * Removal APIs for the PackageKit backend
 *
 * Authors: Copyright © 2023 Serpent OS Developers
 * License: Zlib
 */

module packagekit.backend.remove;

import packagekit.backend : PkBackend;
import packagekit.bitfield;
import packagekit.enums;
import packagekit.job;

export extern (C)
{
    void pk_backend_remove_packages(PkBackend* backend, PkBackendJob* job,
            PkBitfield transactionFlags, char** packageIDs, bool allowDeps, bool autoRemove)
    {
        pk_backend_job_finished(job);
    }
}
