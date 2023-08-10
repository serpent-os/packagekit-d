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
import glib.c.functions : g_strv_length;

import packagekit.plugin : plugin;

export extern (C)
{
    void pk_backend_resolve(PkBackend* backend, PkBackendJob* job,
            PkBitfield filters, char** packageIDS)
    {
        auto j = BackendJob(job);
        scope (exit)
            j.finished;
        j.status(PkStatusEnum.PK_STATUS_ENUM_QUERY);

        auto ids = packageIDS[0 .. g_strv_length(packageIDS)];
        plugin.resolve(j, SafeBitField!PkFilterEnum(filters), ids);
    }

    void pk_backend_what_provides(PkBackend* backend, PkBackendJob* job,
            PkBitfield filters, char** packageIDs)
    {
        BackendJob(job).status(PkStatusEnum.PK_STATUS_ENUM_QUERY).finished;

    }
}
