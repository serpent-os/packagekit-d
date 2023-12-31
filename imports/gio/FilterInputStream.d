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


module gio.FilterInputStream;

private import gio.InputStream;
private import gio.c.functions;
public  import gio.c.types;
private import gobject.ObjectG;


/**
 * Base class for input stream implementations that perform some
 * kind of filtering operation on a base stream. Typical examples
 * of filtering operations are character set conversion, compression
 * and byte order flipping.
 */
public class FilterInputStream : InputStream
{
	/** the main Gtk struct */
	protected GFilterInputStream* gFilterInputStream;

	/** Get the main Gtk struct */
	public GFilterInputStream* getFilterInputStreamStruct(bool transferOwnership = false)
	{
		if (transferOwnership)
			ownedRef = false;
		return gFilterInputStream;
	}

	/** the main Gtk struct as a void* */
	protected override void* getStruct()
	{
		return cast(void*)gFilterInputStream;
	}

	/**
	 * Sets our main struct and passes it to the parent class.
	 */
	public this (GFilterInputStream* gFilterInputStream, bool ownedRef = false)
	{
		this.gFilterInputStream = gFilterInputStream;
		super(cast(GInputStream*)gFilterInputStream, ownedRef);
	}


	/** */
	public static GType getType()
	{
		return g_filter_input_stream_get_type();
	}

	/**
	 * Gets the base stream for the filter stream.
	 *
	 * Returns: a #GInputStream.
	 */
	public InputStream getBaseStream()
	{
		auto __p = g_filter_input_stream_get_base_stream(gFilterInputStream);

		if(__p is null)
		{
			return null;
		}

		return ObjectG.getDObject!(InputStream)(cast(GInputStream*) __p);
	}

	/**
	 * Returns whether the base stream will be closed when @stream is
	 * closed.
	 *
	 * Returns: %TRUE if the base stream will be closed.
	 */
	public bool getCloseBaseStream()
	{
		return g_filter_input_stream_get_close_base_stream(gFilterInputStream) != 0;
	}

	/**
	 * Sets whether the base stream will be closed when @stream is closed.
	 *
	 * Params:
	 *     closeBase = %TRUE to close the base stream.
	 */
	public void setCloseBaseStream(bool closeBase)
	{
		g_filter_input_stream_set_close_base_stream(gFilterInputStream, closeBase);
	}
}
