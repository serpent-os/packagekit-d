/*
 * SPDX-FileCopyrightText: Copyright © 2023 Ikey Doherty
 *
 * SPDX-License-Identifier: Zlib
 */

/**
 * packagekit.backend.list
 *
 * Package list APIs for the PackageKit backend
 *
 * Authors: Copyright © 2023 Ikey Doherty
 * License: Zlib
 */

module packagekit.backend.list;

import packagekit.backend : PkBackend;
import packagekit.bitfield;
import packagekit.job;
import packagekit.enums;
import packagekit.pkg;

import pyd.embedded;
import std.string : format;

export extern (C)
{
    void pk_backend_get_packages(PkBackend* backend, PkBackendJob* job, PkBitfield filters)
    {
        pk_backend_job_set_status(job, PkStatusEnum.PK_STATUS_ENUM_REQUEST);

        auto ctx = new InterpContext();
        ctx.pushDummyFrame();
        scope (exit)
            ctx.popDummyFrame();

        ctx.pisi = py_import("pisi");
        ctx.pdb = ctx.py_eval("pisi.db.packagedb.PackageDB()");
        ctx.idb = ctx.py_eval("pisi.db.installdb.InstallDB()");
        auto pisiPackages = ctx.py_eval(
                "[pdb.get_package_repo(x) for x in pdb.list_packages(None)]");

        const length = pisiPackages.length;
        auto packages = PackageList.create(cast(int) length);

        // Python hackery to get things going
        foreach (ppkgTuple; pisiPackages)
        {
            auto repo = ppkgTuple[1].to_d!string;
            auto ppkg = ppkgTuple[0];
            auto pkg = Package.create();
            auto name = ppkg.name.to_d!string;
            auto history = ppkg.history[0];
            auto vers = history.getattr("version").to_d!string;
            auto release = history.release.to_d!string;
            auto summary = ppkg.summary.to_d!string;
            auto arch = ppkg.architecture;
            const isInstalled = ctx.py_eval(format!"idb.has_package(\"%s\")"(name)).to_d!bool;
            pkg.id = format!"%s;%s-%s;%s;%s"(name, vers, release, arch, repo);
            pkg.summary = summary;
            pkg.info = isInstalled ? PkInfoEnum.PK_INFO_ENUM_INSTALLED
                : PkInfoEnum.PK_INFO_ENUM_AVAILABLE;
            packages ~= pkg;
        }

        pk_backend_job_packages(job, packages.pointer);
        pk_backend_job_finished(job);
    }
}
