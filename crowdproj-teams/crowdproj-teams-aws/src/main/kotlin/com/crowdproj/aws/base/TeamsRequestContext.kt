package com.crowdproj.aws.base

import com.crowdproj.rest.teams.models.ApiResponseTeam
import java.time.Instant

class TeamsRequestContext<T>(
    request: T,
    response: ApiResponseTeam = ApiResponseTeam(),
    exception: Throwable? = null,
    timeStart: Instant = Instant.MIN
): RequestContext<T, ApiResponseTeam>(
    request = request,
    response = response,
    exception = exception,
    timeStart = timeStart
)