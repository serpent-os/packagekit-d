/*
 * SPDX-FileCopyrightText: Copyright © 2023 Ikey Doherty
 *
 * SPDX-License-Identifier: Zlib
 */

/**
 * packagekit.backend.files
 *
 * File APIs for the PackageKit backend
 *
 * Authors: Copyright © 2023 Ikey Doherty
 * License: Zlib
 */

module packagekit.backend.files;

import packagekit.backend : PkBackend;
import packagekit.job;
import packagekit.bitfield;
import packagekit.enums;

export extern (C)
{
    void pk_backend_get_files_local(PkBackend* backend, PkBackendJob* job, char** files)
    {
        pk_backend_job_set_status(job, PkStatusEnum.PK_STATUS_ENUM_QUERY);
        pk_backend_job_finished(job);
    }

    void pk_backend_get_files(PkBackend* backend, PkBackendJob* job, char** files)
    {
        pk_backend_job_finished(job);
    }
}
