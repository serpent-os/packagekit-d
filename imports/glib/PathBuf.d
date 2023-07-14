/*
 * This file is part of gtkD.
 *
 * gtkD is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License
 * as published by the Free Software Foundation; either version 3
 * of the License, or (at your option) any later version, with
 * some exceptions, please read the COPYING file.
 *
 * gtkD is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with gtkD; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110, USA
 */

// generated automatically - do not change
// find conversion definition on APILookup.txt
// implement new conversion functionalities the gir-to-d pakage


module glib.PathBuf;

private import glib.ConstructionException;
private import glib.Str;
private import glib.c.functions;
public  import glib.c.types;


/**
 * `GPathBuf` is a helper type that allows you to easily build paths from
 * individual elements, using the platform specific conventions for path
 * separators.
 * 
 * |[<!-- language="C" -->
 * g_auto (GPathBuf) path;
 * 
 * g_path_buf_init (&path);
 * 
 * g_path_buf_push (&path, "usr");
 * g_path_buf_push (&path, "bin");
 * g_path_buf_push (&path, "echo");
 * 
 * g_autofree char *echo = g_path_buf_to_path (&path);
 * g_assert_cmpstr (echo, ==, "/usr/bin/echo");
 * ]|
 * 
 * You can also load a full path and then operate on its components:
 * 
 * |[<!-- language="C" -->
 * g_auto (GPathBuf) path;
 * 
 * g_path_buf_init_from_path (&path, "/usr/bin/echo");
 * 
 * g_path_buf_pop (&path);
 * g_path_buf_push (&path, "sh");
 * 
 * g_autofree char *sh = g_path_buf_to_path (&path);
 * g_assert_cmpstr (sh, ==, "/usr/bin/sh");
 * ]|
 * 
 * `GPathBuf` is available since GLib 2.76.
 *
 * Since: 2.76
 */
public class PathBuf
{
	/** the main Gtk struct */
	protected GPathBuf* gPathBuf;
	protected bool ownedRef;

	/** Get the main Gtk struct */
	public GPathBuf* getPathBufStruct(bool transferOwnership = false)
	{
		if (transferOwnership)
			ownedRef = false;
		return gPathBuf;
	}

	/** the main Gtk struct as a void* */
	protected void* getStruct()
	{
		return cast(void*)gPathBuf;
	}

	/**
	 * Sets our main struct and passes it to the parent class.
	 */
	public this (GPathBuf* gPathBuf, bool ownedRef = false)
	{
		this.gPathBuf = gPathBuf;
		this.ownedRef = ownedRef;
	}

	~this ()
	{
		if ( ownedRef )
			g_path_buf_free(gPathBuf);
	}


	/**
	 * Clears the contents of the path buffer.
	 *
	 * This function should be use to free the resources in a stack-allocated
	 * `GPathBuf` initialized using g_path_buf_init() or
	 * g_path_buf_init_from_path().
	 *
	 * Since: 2.76
	 */
	public void clear()
	{
		g_path_buf_clear(gPathBuf);
	}

	/**
	 * Clears the contents of the path buffer and returns the built path.
	 *
	 * This function returns `NULL` if the `GPathBuf` is empty.
	 *
	 * See also: g_path_buf_to_path()
	 *
	 * Returns: the built path
	 *
	 * Since: 2.76
	 */
	public string clearToPath()
	{
		auto retStr = g_path_buf_clear_to_path(gPathBuf);

		scope(exit) Str.freeString(retStr);
		return Str.toString(retStr);
	}

	/**
	 * Copies the contents of a path buffer into a new `GPathBuf`.
	 *
	 * Returns: the newly allocated path buffer
	 *
	 * Since: 2.76
	 */
	public PathBuf copy()
	{
		auto __p = g_path_buf_copy(gPathBuf);

		if(__p is null)
		{
			return null;
		}

		return new PathBuf(cast(GPathBuf*) __p, true);
	}

	/**
	 * Frees a `GPathBuf` allocated by g_path_buf_new().
	 *
	 * Since: 2.76
	 */
	public void free()
	{
		g_path_buf_free(gPathBuf);
		ownedRef = false;
	}

	/**
	 * Frees a `GPathBuf` allocated by g_path_buf_new(), and
	 * returns the path inside the buffer.
	 *
	 * This function returns `NULL` if the `GPathBuf` is empty.
	 *
	 * See also: g_path_buf_to_path()
	 *
	 * Returns: the path
	 *
	 * Since: 2.76
	 */
	public string freeToPath()
	{
		auto retStr = g_path_buf_free_to_path(gPathBuf);

		scope(exit) Str.freeString(retStr);
		return Str.toString(retStr);
	}

	/**
	 * Initializes a `GPathBuf` instance.
	 *
	 * Returns: the initialized path builder
	 *
	 * Since: 2.76
	 */
	public PathBuf init()
	{
		auto __p = g_path_buf_init(gPathBuf);

		if(__p is null)
		{
			return null;
		}

		return new PathBuf(cast(GPathBuf*) __p);
	}

	/**
	 * Initializes a `GPathBuf` instance with the given path.
	 *
	 * Params:
	 *     path = a file system path
	 *
	 * Returns: the initialized path builder
	 *
	 * Since: 2.76
	 */
	public PathBuf initFromPath(string path)
	{
		auto __p = g_path_buf_init_from_path(gPathBuf, Str.toStringz(path));

		if(__p is null)
		{
			return null;
		}

		return new PathBuf(cast(GPathBuf*) __p);
	}

	/**
	 * Removes the last element of the path buffer.
	 *
	 * If there is only one element in the path buffer (for example, `/` on
	 * Unix-like operating systems or the drive on Windows systems), it will
	 * not be removed and %FALSE will be returned instead.
	 *
	 * |[<!-- language="C" -->
	 * GPathBuf buf, cmp;
	 *
	 * g_path_buf_init_from_path (&buf, "/bin/sh");
	 *
	 * g_path_buf_pop (&buf);
	 * g_path_buf_init_from_path (&cmp, "/bin");
	 * g_assert_true (g_path_buf_equal (&buf, &cmp));
	 * g_path_buf_clear (&cmp);
	 *
	 * g_path_buf_pop (&buf);
	 * g_path_buf_init_from_path (&cmp, "/");
	 * g_assert_true (g_path_buf_equal (&buf, &cmp));
	 * g_path_buf_clear (&cmp);
	 *
	 * g_path_buf_clear (&buf);
	 * ]|
	 *
	 * Returns: `TRUE` if the buffer was modified and `FALSE` otherwise
	 *
	 * Since: 2.76
	 */
	public bool pop()
	{
		return g_path_buf_pop(gPathBuf) != 0;
	}

	/**
	 * Extends the given path buffer with @path.
	 *
	 * If @path is absolute, it replaces the current path.
	 *
	 * If @path contains a directory separator, the buffer is extended by
	 * as many elements the path provides.
	 *
	 * On Windows, both forward slashes and backslashes are treated as
	 * directory separators. On other platforms, %G_DIR_SEPARATOR_S is the
	 * only directory separator.
	 *
	 * |[<!-- language="C" -->
	 * GPathBuf buf, cmp;
	 *
	 * g_path_buf_init_from_path (&buf, "/tmp");
	 * g_path_buf_push (&buf, ".X11-unix/X0");
	 * g_path_buf_init_from_path (&cmp, "/tmp/.X11-unix/X0");
	 * g_assert_true (g_path_buf_equal (&buf, &cmp));
	 * g_path_buf_clear (&cmp);
	 *
	 * g_path_buf_push (&buf, "/etc/locale.conf");
	 * g_path_buf_init_from_path (&cmp, "/etc/locale.conf");
	 * g_assert_true (g_path_buf_equal (&buf, &cmp));
	 * g_path_buf_clear (&cmp);
	 *
	 * g_path_buf_clear (&buf);
	 * ]|
	 *
	 * Params:
	 *     path = a path
	 *
	 * Returns: the same pointer to @buf, for convenience
	 *
	 * Since: 2.76
	 */
	public PathBuf push(string path)
	{
		auto __p = g_path_buf_push(gPathBuf, Str.toStringz(path));

		if(__p is null)
		{
			return null;
		}

		return new PathBuf(cast(GPathBuf*) __p);
	}

	/**
	 * Adds an extension to the file name in the path buffer.
	 *
	 * If @extension is `NULL`, the extension will be unset.
	 *
	 * If the path buffer does not have a file name set, this function returns
	 * `FALSE` and leaves the path buffer unmodified.
	 *
	 * Params:
	 *     extension = the file extension
	 *
	 * Returns: `TRUE` if the extension was replaced, and `FALSE` otherwise
	 *
	 * Since: 2.76
	 */
	public bool setExtension(string extension)
	{
		return g_path_buf_set_extension(gPathBuf, Str.toStringz(extension)) != 0;
	}

	/**
	 * Sets the file name of the path.
	 *
	 * If the path buffer is empty, the filename is left unset and this
	 * function returns `FALSE`.
	 *
	 * If the path buffer only contains the root element (on Unix-like operating
	 * systems) or the drive (on Windows), this is the equivalent of pushing
	 * the new @file_name.
	 *
	 * If the path buffer contains a path, this is the equivalent of
	 * popping the path buffer and pushing @file_name, creating a
	 * sibling of the original path.
	 *
	 * |[<!-- language="C" -->
	 * GPathBuf buf, cmp;
	 *
	 * g_path_buf_init_from_path (&buf, "/");
	 *
	 * g_path_buf_set_filename (&buf, "bar");
	 * g_path_buf_init_from_path (&cmp, "/bar");
	 * g_assert_true (g_path_buf_equal (&buf, &cmp));
	 * g_path_buf_clear (&cmp);
	 *
	 * g_path_buf_set_filename (&buf, "baz.txt");
	 * g_path_buf_init_from_path (&cmp, "/baz.txt");
	 * g_assert_true (g_path_buf_equal (&buf, &cmp);
	 * g_path_buf_clear (&cmp);
	 *
	 * g_path_buf_clear (&buf);
	 * ]|
	 *
	 * Params:
	 *     fileName = the file name in the path
	 *
	 * Returns: `TRUE` if the file name was replaced, and `FALSE` otherwise
	 *
	 * Since: 2.76
	 */
	public bool setFilename(string fileName)
	{
		return g_path_buf_set_filename(gPathBuf, Str.toStringz(fileName)) != 0;
	}

	/**
	 * Retrieves the built path from the path buffer.
	 *
	 * On Windows, the result contains backslashes as directory separators,
	 * even if forward slashes were used in input.
	 *
	 * If the path buffer is empty, this function returns `NULL`.
	 *
	 * Returns: the path
	 *
	 * Since: 2.76
	 */
	public string toPath()
	{
		auto retStr = g_path_buf_to_path(gPathBuf);

		scope(exit) Str.freeString(retStr);
		return Str.toString(retStr);
	}

	/**
	 * Compares two path buffers for equality and returns `TRUE`
	 * if they are equal.
	 *
	 * The path inside the paths buffers are not going to be normalized,
	 * so `X/Y/Z/A/..`, `X/./Y/Z` and `X/Y/Z` are not going to be considered
	 * equal.
	 *
	 * This function can be passed to g_hash_table_new() as the
	 * `key_equal_func` parameter.
	 *
	 * Params:
	 *     v1 = a path buffer to compare
	 *     v2 = a path buffer to compare
	 *
	 * Returns: `TRUE` if the two path buffers are equal,
	 *     and `FALSE` otherwise
	 *
	 * Since: 2.76
	 */
	public static bool equal(void* v1, void* v2)
	{
		return g_path_buf_equal(v1, v2) != 0;
	}

	/**
	 * Allocates a new `GPathBuf`.
	 *
	 * Returns: the newly allocated path buffer
	 *
	 * Since: 2.76
	 *
	 * Throws: ConstructionException GTK+ fails to create the object.
	 */
	public this()
	{
		auto __p = g_path_buf_new();

		if(__p is null)
		{
			throw new ConstructionException("null returned by new");
		}

		this(cast(GPathBuf*) __p);
	}

	/**
	 * Allocates a new `GPathBuf` with the given @path.
	 *
	 * Params:
	 *     path = the path used to initialize the buffer
	 *
	 * Returns: the newly allocated path buffer
	 *
	 * Since: 2.76
	 *
	 * Throws: ConstructionException GTK+ fails to create the object.
	 */
	public this(string path)
	{
		auto __p = g_path_buf_new_from_path(Str.toStringz(path));

		if(__p is null)
		{
			throw new ConstructionException("null returned by new_from_path");
		}

		this(cast(GPathBuf*) __p);
	}
}
