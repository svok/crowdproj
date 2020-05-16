package com.crowdproj.aws.handlers

import com.crowdproj.aws.base.TeamsRequestContext
import com.crowdproj.common.ILogger
import com.crowdproj.rest.teams.models.RestQueryTeamGet
import com.crowdproj.rest.teams.models.RestResponseTeam
import com.fasterxml.jackson.databind.JsonNode
import com.fasterxml.jackson.databind.node.NullNode
import com.fasterxml.jackson.databind.node.ObjectNode
import java.time.Instant

data class TeamsGetRequestContext(
    override var requestData: JsonNode = NullNode.instance,
    override var request: RestQueryTeamGet = RestQueryTeamGet(),
    override var response: RestResponseTeam = RestResponseTeam(),
    override var exception: Throwable? = null,
    override var timeStart: Instant = Instant.MIN,
    override var logger: ILogger = ILogger.NONE
): TeamsRequestContext<RestQueryTeamGet>(
    requestData = requestData,
    request = request,
    response = response,
    exception = exception,
    timeStart = timeStart,
    logger = logger
)