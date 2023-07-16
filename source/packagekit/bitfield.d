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
import std.traits;
import std.algorithm;
import std.range;
import std.meta;

/**
 * Core type used in PackageKit
 */
public alias PkBitfield = uint64_t;

/** 
 * Specialist bitfield adaptation for dlang to prevent mixing
 * different enum types as can happen in C land.
 *
 * Params:
 *  E = Enum type for this bitfield
 */
public struct SafeBitField(E) if (is(E == enum))
{
    /** 
     * The core type is the same as a pk_bitfield, ie. a uint64_t.
     */
    PkBitfield core;
    alias core this;

    /** 
     * Returns: BitField value for the enum
     * Params:
     *   num = enum to query
     */
    static pure value(E num) => ((cast(PkBitfield) 1) << num);

    /** 
     * Wrapper to add to the enum.
     *
     * Params:
     *   num = value
     */
    auto add(E num) => core |= num;

    /** 
     * Wrapper to remove from the enum
     *
     * Params:
     *   num = value
     */
    auto remove(E num) => core &= ~value(num);

    /** 
     * Invert a value in the enum
     *
     * Params:
     *   num = value
     */
    auto invert(E num) => core ^= value(num);

    /** 
     * Test if a value is present
     *
     * Params:
     *   op = Always `in`
     *   num = value
     * Returns: true if the bitfield contains the given enum value
     */
    pure opBinary(string op : "in")(E num) => ((core & value(num)) > 0);

    /** 
     * Instantiate a bitfield from the given input types
     *
     * Params:
     *   enums = Enums to instantiate the bitfield from
     * Returns: Strongly typed bitfield
     */
    pure static auto from(E...)(E enums)
            if (allSameType!E && E.length > 0 && is(E[0] == enum))
    {
        alias RetType = E[0];
        // Convert all enums into `pk_bitfield_value` and return their sum
        return SafeBitField!RetType(enums.only.map!((v) => SafeBitField!RetType.value(v)).sum);
    }
}

/** 
 * Produce a safe bit field (at compile time) from the strongly typed (not mismatched!) enums
 *
 * Params:
 *   enums = Set of enums to build a SafeBitField from
 * Returns: Strongly typed bitfield
 */
auto safeBitField(E...)(E enums) if (allSameType!E && E.length > 0 && is(E[0] == enum))
{
    return SafeBitField!(E[0]).from(enums);
}
