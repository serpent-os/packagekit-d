/*
 * SPDX-FileCopyrightText: Copyright © 2023 Serpent OS Developers
 *
 * SPDX-License-Identifier: Zlib
 */

/**
 * packagekit.backend
 *
 * PackageKit plugin for packagekit-d API
 * Exposes a C API to match https://github.com/PackageKit/PackageKit/blob/main/src/pk-backend.c#L494
 *
 * This module is split across multiple files to make the implementation simpler and group by logical
 * functionality.
 *
 * Authors: Copyright © 2023 Serpent OS Developers
 * License: Zlib
 */

module packagekit.backend;

@safe:

import glib.c.functions : g_strdupv, g_strv_length;
import glib.c.types : GKeyFile;
import packagekit.bitfield;
import packagekit.enums;
import packagekit.job;
import std.meta;
import std.stdint : uint64_t;
import std.traits;
import core.runtime : Runtime;
import std.algorithm : among;

public import packagekit.backend.deps;
public import packagekit.backend.download;
public import packagekit.backend.files;
public import packagekit.backend.info;
public import packagekit.backend.install;
public import packagekit.backend.jobs;
public import packagekit.backend.list;
public import packagekit.backend.lookup;
public import packagekit.backend.refresh;
public import packagekit.backend.remove;
public import packagekit.backend.repos;
public import packagekit.backend.search;
public import packagekit.backend.updates;
import packagekit.plugin : plugin;

export extern (C)
{
    struct PkBackend;

    /** 
     * Params:
     *   self = Current backend
     * Returns: backend author
     */
    const(char*) pk_backend_get_author(PkBackend* self) => plugin.author;

    /** 
     * Params:
     *   self = Current backend
     * Returns: backend name
     */
    const(char*) pk_backend_get_name(PkBackend* self) => plugin.name;

    /** 
     * Params:
     *   self = Current backend
     * Returns: backend description
     */
    const(char*) pk_backend_get_description(PkBackend* self) => plugin.description;

    /** 
     * Initialise the backend
     *
     * Params:
     *   config = PackageKit's configuration file
     *   self = Current backend
     */
    void pk_backend_initialize(GKeyFile* config, PkBackend* self) @trusted
    {
        Runtime.initialize();
        imported!"core.stdc.stdio".puts("[packagekit-d] Init");
        plugin.initialize();
    }

    /** 
     * Destroy the backend
     *
     * Params:  
     *   self = Current backend
     */
    void pk_backend_destroy(PkBackend* self) @trusted
    {
        imported!"core.stdc.stdio".puts("[packagekit-d] Destroy");
        Runtime.terminate();
    }

    /** 
     * Notify the daemon of the supported groups. We hard-code as supporting
     * all of them.
     *
     * Params:
     *   self = Current backend
     * Returns: Supported groups for enumeration
     */
    PkBitfield pk_backend_get_groups(PkBackend* self)
    {
        with (PkGroupEnum)
        {
            template GroupFilter(PkGroupEnum n)
            {
                enum GroupFilter = !n.among(PK_GROUP_ENUM_UNKNOWN, PK_GROUP_ENUM_LAST);
            }

            return safeBitField(Filter!(GroupFilter, EnumMembers!PkGroupEnum));
        }
    }

    /** 
     * Exposes all of our supported roles.
     *
     * We explicitly do not support EULA, cancelation or showing old transactions atm.
     *
     * Params:
     *   self = Current backend
     * Returns: Supported roles (APIs)
     */
    PkBitfield pk_backend_get_roles(PkBackend* self)
    {
        with (PkRoleEnum)
        {
            template RoleFilter(PkRoleEnum n)
            {
                enum RoleFilter = !n.among(PK_ROLE_ENUM_UNKNOWN, PK_ROLE_ENUM_ACCEPT_EULA,
                            PK_ROLE_ENUM_CANCEL, PK_ROLE_ENUM_GET_OLD_TRANSACTIONS);
            }

            return safeBitField(Filter!(RoleFilter, EnumMembers!PkRoleEnum));
        }
    }

    /** 
     * Exposes all of our supported filters
     *
     * Params:
     *   self = Current backend
     * Returns: Supported filters
     */
    PkBitfield pk_backend_get_filters(PkBackend* self)
    {
        with (PkFilterEnum)
        {
            return safeBitField(PK_FILTER_ENUM_DEVELOPMENT, PK_FILTER_ENUM_GUI,
                    PK_FILTER_ENUM_INSTALLED);
        }
    }

    PkBitfield pk_backend_get_provides(PkBackend* self) => 0;

    /** 
     * Params:
     *   self = Current backend
     * Returns: An allocated copy of supported mimetypes
     */
    char** pk_backend_get_mime_types(PkBackend* self) @trusted => (
            cast(char**) plugin.mimeTypes.ptr).g_strdupv;

    /** 
     * We don't yet support threaded usage.
     * Params:
     *   self = Current backend
     * Returns: False. Always.
     */
    bool pk_backend_supports_parallelization(PkBackend* self) => false;

    /* NOT SUPPORTED */
    void pk_backend_repair_system(PkBackend* backend, PkBackendJob* job,
            PkBitfield transactionFlags)
    {
        BackendJob(job).finished;
    }
}
