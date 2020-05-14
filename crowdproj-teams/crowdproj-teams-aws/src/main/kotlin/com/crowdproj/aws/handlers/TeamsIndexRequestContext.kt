package com.crowdproj.aws.handlers

import com.crowdproj.aws.base.TeamsRequestContext
import com.crowdproj.common.ILogger
import com.crowdproj.rest.teams.models.ApiQueryTeamFind
import com.crowdproj.rest.teams.models.ApiResponseTeam
import com.fasterxml.jackson.databind.JsonNode
import com.fasterxml.jackson.databind.node.NullNode
import java.time.Instant

data class TeamsIndexRequestContext(
    override var requestData: JsonNode = NullNode.instance,
    override var request: ApiQueryTeamFind = ApiQueryTeamFind(),
    override var response: ApiResponseTeam = ApiResponseTeam(),
    override var exception: Throwable? = null,
    override var timeStart: Instant = Instant.MIN,
    override var logger: ILogger = ILogger.NONE
): TeamsRequestContext<ApiQueryTeamFind>(
    requestData = requestData,
    request = request,
    response = response,
    exception = exception,
    timeStart = timeStart,
    logger = logger
)