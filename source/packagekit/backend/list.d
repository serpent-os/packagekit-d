/*
 * SPDX-FileCopyrightText: Copyright © 2023 Serpent OS Developers
 *
 * SPDX-License-Identifier: Zlib
 */

/**
 * packagekit.backend.list
 *
 * Package list APIs for the PackageKit backend
 *
 * Authors: Copyright © 2023 Serpent OS Developers
 * License: Zlib
 */

module packagekit.backend.list;

import packagekit.backend : PkBackend;
import packagekit.bitfield;
import packagekit.job;
import packagekit.enums;
import packagekit.pkg;

import packagekit.plugin : plugin;

export extern (C)
{
    void pk_backend_get_packages(PkBackend* backend, PkBackendJob* job, PkBitfield filters)
    {
        auto j = BackendJob(job);
        j.status(PkStatusEnum.PK_STATUS_ENUM_REQUEST);
        plugin.listPackages(j, SafeBitField!PkFilterEnum(filters));
        j.finished;
    }
}
