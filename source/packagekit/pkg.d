/*
 * SPDX-FileCopyrightText: Copyright © 2023 Serpent OS Developers
 *
 * SPDX-License-Identifier: Zlib
 */

/**
 * packagekit.pkg
 *
 * Encapsulates PkPackage APIs
 *
 * Authors: Copyright © 2023 Serpent OS Developers
 * License: Zlib
 */

module packagekit.pkg;

import glib.c.types : GError, GPtrArray;
import glib.c.functions : g_error_free, g_ptr_array_new_with_free_func,
    g_ptr_array_new_full, g_ptr_array_unref, g_ptr_array_add;
import gobject.c.functions : g_object_unref, g_object_ref;
import packagekit.enums;
import std.string : fromStringz, toStringz;
import std.exception : enforce;

version (LDC)
    import ldc.attributes : weak;
else
    import core.attributes : weak;

struct PackageList
{
    @disable this();
    @disable this(this);

    /** 
     * Create a new PackageList
     *
     * Params:
     *   reservedSize = Minimum size for the list
     */
    static auto create(uint reservedSize = 0) @trusted
    {
        GPtrArray* ptr = reservedSize != 0 ? g_ptr_array_new_full(reservedSize, &g_object_unref)
            : g_ptr_array_new_with_free_func(&g_object_unref);
        ptr.enforce;
        PackageList p = {ptr: ptr,};
        return p;
    }

    void opOpAssign(string op : "~")(scope auto ref Package pkg)
    {
        enforce(pkg.ptr !is null);
        g_ptr_array_add(ptr, g_object_ref(pkg.ptr));
    }

    invariant ()
    {
        assert(ptr !is null);
    }

    ~this() @trusted
    {
        if (ptr is null)
            return;
        g_ptr_array_unref(ptr);
        ptr = null;
    }

    package auto pointer() => ptr;

private:

    GPtrArray* ptr;
}

struct Package
{
    @disable this();
    @disable this(this);

    /** 
     * Returns: New PkPackage
     */
    static auto create()
    {
        PkPackage* ptr = pk_package_new.enforce;
        Package p = {ptr: ptr,};
        return p;
    }

    /** 
     * Update the PkgID
     *
     * Params:
     *   id = New ID for this package
     */
    @property void id(string id) @trusted
    {
        GError* error;
        scope (exit)
            if (error !is null)
                g_error_free(error);
        pk_package_set_id(ptr, id.toStringz, &error).enforce(error.message.fromStringz);
    }

    /** 
     * Returns: ID for this package
     */
    @property auto id() @trusted => pk_package_get_id(ptr);

    /** 
     * Update the info
     *
     * Params:
     *   info = New info 
     */
    @property void info(PkInfoEnum info) @trusted => pk_package_set_info(ptr, info);

    /** 
     * Returns: info
     */
    @property auto info() @trusted => pk_package_get_info(ptr);

    /** 
     * Set the summary
     *
     * Params:
     *   summary = New summary
     */
    @property void summary(string summary) @trusted => pk_package_set_summary(ptr,
            summary.toStringz);

    /** 
     * Returns: the summary
     */
    @property auto summary() @trusted => pk_package_get_summary(ptr);

    /** 
     * Returns: Architecture of the pkg
     */
    @property auto arch() @trusted => pk_package_get_arch(ptr);

    /** 
     * Returns: Data component (typically the repository ID)
     */
    @property auto data() @trusted => pk_package_get_data(ptr);

    /** 
     * Update the severity for this package
     *
     * Params:
     *   s = New severity
     */
    @property void updateSeverity(PkInfoEnum s) @trusted => pk_package_set_update_severity(ptr, s);

    /** 
     * Returns: Update severity for this package
     */
    @property auto updateSeverity() @trusted => pk_package_get_update_severity(ptr);

    invariant ()
    {
        assert(ptr !is null);
    }

    /**
     * Handle cleanup
     */
    ~this() @trusted
    {
        if (ptr is null)
            return;
        g_object_unref(ptr);
        ptr = null;
    }

private:
    PkPackage* ptr;
}

private extern (C)
{
    struct PkPackage;
    @weak PkPackage* pk_package_new();
    @weak bool pk_package_set_id(PkPackage* self, const(char*) id, GError** error);
    @weak bool pk_package_parse(PkPackage* self, GError* error);
    @weak void pk_package_print(PkPackage* self);
    @weak void pk_package_equal(PkPackage* a, PkPackage* b);
    @weak void pk_package_equal_id(PkPackage* a, PkPackage* b);
    @weak const(char*) pk_package_get_id(PkPackage* self);
    @weak PkInfoEnum pk_package_get_info(PkPackage* self);
    @weak void pk_package_set_info(PkPackage* self, PkInfoEnum info);
    @weak void pk_package_set_summary(PkPackage* self, const(char*) summary);
    @weak const(char*) pk_package_get_summary(PkPackage* self);
    @weak const(char*) pk_package_get_name(PkPackage* self);
    @weak const(char*) pk_package_get_arch(PkPackage* self);
    @weak const(char*) pk_package_get_data(PkPackage* self);
    @weak PkInfoEnum pk_package_get_update_severity(PkPackage* self);
    @weak void pk_package_set_update_severity(PkPackage* self, PkInfoEnum info);
}
