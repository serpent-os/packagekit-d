/*
 * SPDX-FileCopyrightText: Copyright © 2023 Serpent OS Developers
 *
 * SPDX-License-Identifier: Zlib
 */

/**
 * packagekit.plugin
 *
 * The global plugin API for packagekit-d
 *
 * Authors: Copyright © 2023 Serpent OS Developers
 * License: Zlib
 */

module packagekit.plugin;

@safe:

import std.string : toStringz;
import std.array : array;
import std.algorithm : map;
import std.exception : enforce;

public import packagekit.enums;
public import packagekit.bitfield;
public import packagekit.job;

private __gshared Plugin pluginImplementation = null;

/** 
 * Implementations must provide this method otherwise we can't init!
 *
 * Returns: New Plugin
 */
extern (C) Plugin packagekit_d_plugin_create();

/**
 * Cleanup the current implementation
 */
shared static ~this() @trusted
{
    if (pluginImplementation)
    {
        pluginImplementation.destroy();
        pluginImplementation = null;
    }
}

/**
 * Returns: The global plugin implementation
 * Throws: Exception if the implementation is unregistered
 */
static Plugin plugin() @trusted
{
    if (pluginImplementation is null)
    {
        pluginImplementation = packagekit_d_plugin_create();
    }
    enforce(pluginImplementation !is null, "No plugin implementation present!");
    return pluginImplementation;
}

/** 
 * Implementations must override this class (`final`) to implement the required
 * functionality. packagekit-d will take care of the `extern(C)` translation and
 * permit a clean plugin API.
 */
public abstract class Plugin
{

    @disable this();

    /** 
     * 
     * Params:
     *   name = Name for the plugin
     *   description = Description of the functionality
     *   author = Who wrote it
     *   mimeTypes = What mimetypes are supported?
     */
    this(string name, string description, string author, string[] mimeTypes)
    {
        () @trusted {
            cName = cast(char*) name.toStringz;
            cDescription = cast(char*) description.toStringz;
            cAuthor = cast(char*) author.toStringz;

            // Sort it out for gstrv...
            if (mimeTypes !is null && mimeTypes.length > 0)
            {
                cMimeTypes = mimeTypes.map!(m => cast(char*) m.toStringz).array;
                cMimeTypes ~= null;
            }
            else
            {
                cMimeTypes = new char*[1];
                cMimeTypes[0] = null;
            }
        }();
    }

    /** 
     * List packages for the backend. Populate the PkBackendJob by its packages method
     *
     * Params:
     *   job = The current backend job
     *   filter = The applicable filter
     */
    abstract void listPackages(scope ref BackendJob job, SafeBitField!PkFilterEnum filter);

package:
    pure name() => cName;
    pure description() => cDescription;
    pure author() => cAuthor;
    pure mimeTypes() => cMimeTypes;

private:

    char* cName;
    char* cDescription;
    char* cAuthor;
    char*[] cMimeTypes = [null];
}
