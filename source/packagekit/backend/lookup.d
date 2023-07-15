/*
 * SPDX-FileCopyrightText: Copyright © 2023 Ikey Doherty
 *
 * SPDX-License-Identifier: Zlib
 */

/**
 * packagekit.backend.lookup
 *
 * Lookup (resolve/providers) APIs for the PackageKit backend
 *
 * Authors: Copyright © 2023 Ikey Doherty
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
        pk_backend_job_finished(job);
    }

    void pk_backend_what_provides(PkBackend* backend, PkBackendJob* job,
            PkBitfield filters, char** values)
    {
        pk_backend_job_set_status(job, PkStatusEnum.PK_STATUS_ENUM_REQUEST);
        pk_backend_job_finished(job);
    }
}
