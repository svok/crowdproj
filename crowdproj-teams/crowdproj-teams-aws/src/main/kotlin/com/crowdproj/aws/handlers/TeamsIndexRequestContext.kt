package com.crowdproj.aws.handlers

import com.crowdproj.aws.base.TeamsRequestContext
import com.crowdproj.common.ILogger
import com.crowdproj.rest.teams.models.RestQueryTeamFind
import com.crowdproj.rest.teams.models.RestResponseTeam
import com.fasterxml.jackson.databind.JsonNode
import com.fasterxml.jackson.databind.node.NullNode
import java.time.Instant

data class TeamsIndexRequestContext(
    override var requestData: JsonNode = NullNode.instance,
    override var request: RestQueryTeamFind = RestQueryTeamFind(),
    override var response: RestResponseTeam = RestResponseTeam(),
    override var exception: Throwable? = null,
    override var timeStart: Instant = Instant.MIN,
    override var logger: ILogger = ILogger.NONE
): TeamsRequestContext<RestQueryTeamFind>(
    requestData = requestData,
    request = request,
    response = response,
    exception = exception,
    timeStart = timeStart,
    logger = logger
)