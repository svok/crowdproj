package com.crowdproj.aws.base

import com.crowdproj.common.ILogger
import com.crowdproj.rest.teams.models.RestResponseTeam
import com.fasterxml.jackson.databind.JsonNode
import java.time.Instant

open class TeamsRequestContext<T>(
    requestData: JsonNode,
    request: T,
    response: RestResponseTeam = RestResponseTeam(),
    exception: Throwable? = null,
    timeStart: Instant = Instant.MIN,
    logger: ILogger
): RequestContext<T, RestResponseTeam>(
    requestData = requestData,
    request = request,
    response = response,
    exception = exception,
    timeStart = timeStart,
    logger = logger
)