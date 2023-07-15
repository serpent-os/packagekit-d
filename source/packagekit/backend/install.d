/*
 * SPDX-FileCopyrightText: Copyright © 2023 Ikey Doherty
 *
 * SPDX-License-Identifier: Zlib
 */

/**
 * packagekit.backend.install
 *
 * Installation APIs for the PackageKit backend
 *
 * Authors: Copyright © 2023 Ikey Doherty
 * License: Zlib
 */

module packagekit.backend.install;

import packagekit.backend : PkBackend;
import packagekit.job;
import packagekit.bitfield;
import packagekit.enums;

export extern (C)
{
    void pk_backend_install_files(PkBackend* backend, PkBackendJob* job,
            PkBitfield transactionFlags)
    {
        pk_backend_job_finished(job);
    }

    void pk_backend_install_packages(PkBackend* backend, PkBackendJob* job,
            PkBitfield transactionFlags, char** packageIDs)
    {
        pk_backend_job_finished(job);
    }

    void pk_backend_install_signature(PkBackend* backend, PkBackendJob* job,
            PkSigTypeEnum type, const(char*) keyID, const(char*) packageID)
    {
        pk_backend_job_finished(job);
    }
}
