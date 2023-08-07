/*
 * SPDX-FileCopyrightText: Copyright © 2023 Serpent OS Developers
 *
 * SPDX-License-Identifier: Zlib
 */

/**
 * packagekit.backend.search
 *
 * Search APIs for the PackageKit backend
 *
 * Authors: Copyright © 2023 Serpent OS Developers
 * License: Zlib
 */

module packagekit.backend.search;

import packagekit.backend : PkBackend;
import packagekit.job;
import packagekit.bitfield;

export extern (C)
{

    void pk_backend_search_details(PkBackend* backend, PkBackendJob* job,
            PkBitfield filters, char** values)
    {
        BackendJob(job).finished;
    }

    void pk_backend_search_files(PkBackend* backend, PkBackendJob* job,
            PkBitfield filters, char** values)
    {
        BackendJob(job).finished;
    }

    void pk_backend_search_groups(PkBackend* backend, PkBackendJob* job,
            PkBitfield filters, char** values)
    {
        BackendJob(job).finished;
    }

    void pk_backend_search_names(PkBackend* backend, PkBackendJob* job,
            PkBitfield filters, char** values)
    {
        BackendJob(job).finished;
    }

}
