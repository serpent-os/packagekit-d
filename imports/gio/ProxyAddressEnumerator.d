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


module gio.ProxyAddressEnumerator;

private import gio.SocketAddressEnumerator;
private import gio.c.functions;
public  import gio.c.types;


/**
 * #GProxyAddressEnumerator is a wrapper around #GSocketAddressEnumerator which
 * takes the #GSocketAddress instances returned by the #GSocketAddressEnumerator
 * and wraps them in #GProxyAddress instances, using the given
 * #GProxyAddressEnumerator:proxy-resolver.
 * 
 * This enumerator will be returned (for example, by
 * g_socket_connectable_enumerate()) as appropriate when a proxy is configured;
 * there should be no need to manually wrap a #GSocketAddressEnumerator instance
 * with one.
 */
public class ProxyAddressEnumerator : SocketAddressEnumerator
{
	/** the main Gtk struct */
	protected GProxyAddressEnumerator* gProxyAddressEnumerator;

	/** Get the main Gtk struct */
	public GProxyAddressEnumerator* getProxyAddressEnumeratorStruct(bool transferOwnership = false)
	{
		if (transferOwnership)
			ownedRef = false;
		return gProxyAddressEnumerator;
	}

	/** the main Gtk struct as a void* */
	protected override void* getStruct()
	{
		return cast(void*)gProxyAddressEnumerator;
	}

	/**
	 * Sets our main struct and passes it to the parent class.
	 */
	public this (GProxyAddressEnumerator* gProxyAddressEnumerator, bool ownedRef = false)
	{
		this.gProxyAddressEnumerator = gProxyAddressEnumerator;
		super(cast(GSocketAddressEnumerator*)gProxyAddressEnumerator, ownedRef);
	}


	/** */
	public static GType getType()
	{
		return g_proxy_address_enumerator_get_type();
	}
}
