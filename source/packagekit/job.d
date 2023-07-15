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

extern (C) struct PkBackendJob;

@weak extern (C) void pk_backend_job_finished(PkBackendJob* self) @trusted;
