/*
 * SPDX-FileCopyrightText: Copyright © 2023 Ikey Doherty
 *
 * SPDX-License-Identifier: Zlib
 */

/**
 * packagekit.job
 *
 * Encapsulates PkBackendJob via weak linkage
 *
 * Authors: Copyright © 2023 Ikey Doherty
 * License: Zlib
 */

module packagekit.job;

import ldc.attributes : weak;
import packagekit.enums : PkInfoEnum, PkStatusEnum, PkErrorEnum;

extern (C) struct PkBackendJob;

@weak extern (C) void pk_backend_job_finished(PkBackendJob* self) @trusted;
@weak extern (C) void pk_backend_job_package(PkBackendJob* self,
        PkInfoEnum info, const char* pkgID, const char* summary) @trusted;
@weak extern (C) void pk_backend_job_set_status(PkBackendJob* job, PkStatusEnum status) @trusted;
@weak extern (C) void pk_backend_job_error_code(PkBackendJob* job, PkErrorEnum code) @trusted;
