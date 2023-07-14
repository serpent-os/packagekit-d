/*
 * SPDX-FileCopyrightText: Copyright © 2023 Ikey Doherty
 *
 * SPDX-License-Identifier: Zlib
 */

/**
 * main
 *
 * Main test app for the API being fleshed out
 *
 * Authors: Copyright © 2023 Ikey Doherty
 * License: Zlib
 */

module main;

import pyd.pyd;

/**
 * Load python2.7
 */
shared static this()
{
    py_init();
}

/**
 * Uninitialise python2.7
 */
shared static ~this()
{
    py_finish();
}

void main()
{
    imported!"std.stdio".writeln("TODO: Anything useful");
}
