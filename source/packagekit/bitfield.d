/*
 * SPDX-FileCopyrightText: Copyright © 2023 Ikey Doherty
 *
 * SPDX-License-Identifier: Zlib
 */

/**
 * packagekit.backend
 *
 * PackageKit plugin for deopkg API
 * Exposes a C API to match https://github.com/PackageKit/PackageKit/blob/main/src/pk-backend.c#L494
 *
 * Authors: Copyright © 2023 Ikey Doherty
 * License: Zlib
 */

module packagekit.bitfield;

import std.stdint : uint64_t;

/**
 * Core type used in PackageKit
 */
public alias PkBitfield = uint64_t;

/**
 * Cleaner port of pk-bitfield.h fields
 */
pure pk_bitfield_value(E : uint)(E num) => ((cast(PkBitfield) 1) << num);
pure pk_bitfield_add(P : PkBitfield, E)(P field, E num) => field | num;
pure pk_bitfield_remove(P : PkBitfield, E)(P field, E num) => field & ~pk_bitfield_value(num);
pure pk_bitfield_invert(P : PkBitfield, E)(P field, E num) => field ^ pk_bitfield_value(num);
pure pk_bitfield_contains(P : PkBitfield, E)(P field, E num) => !!(
        (field & pk_bitfield_value(num)) > 0);

/**
 * Produce a bitfield from the input enums
 */
pure pk_bitfield_from_enums(E...)(E enums)
{
    PkBitfield ret;
    static foreach (arg; enums)
    {
        ret += pk_bitfield_value(arg);
    }
    return ret;
}
