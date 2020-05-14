package com.crowdproj.aws.base

import com.crowdproj.common.ILogger
import com.crowdproj.rest.teams.models.ApiResponseTeam
import com.crowdproj.teams.main.TeamService
import com.fasterxml.jackson.databind.JsonNode
import java.time.Instant

open class TeamsRequestContext<T>(
    requestData: JsonNode,
    request: T,
    response: ApiResponseTeam = ApiResponseTeam(),
    exception: Throwable? = null,
    timeStart: Instant = Instant.MIN,
    logger: ILogger
): RequestContext<T, ApiResponseTeam>(
    requestData = requestData,
    request = request,
    response = response,
    exception = exception,
    timeStart = timeStart,
    logger = logger
)