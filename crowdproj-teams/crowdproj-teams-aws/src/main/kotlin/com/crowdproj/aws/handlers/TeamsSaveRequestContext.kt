package com.crowdproj.aws.handlers

import com.crowdproj.aws.base.TeamsRequestContext
import com.crowdproj.common.ILogger
import com.crowdproj.rest.teams.models.RestQueryTeamSave
import com.crowdproj.rest.teams.models.RestResponseTeam
import com.fasterxml.jackson.databind.JsonNode
import com.fasterxml.jackson.databind.node.NullNode
import java.time.Instant

data class TeamsSaveRequestContext(
    override var requestData: JsonNode = NullNode.instance,
    override var request: RestQueryTeamSave = RestQueryTeamSave(),
    override var response: RestResponseTeam = RestResponseTeam(),
    override var exception: Throwable? = null,
    override var timeStart: Instant = Instant.MIN,
    override var logger: ILogger = ILogger.NONE
): TeamsRequestContext<RestQueryTeamSave>(
    requestData = requestData,
    request = request,
    response = response,
    exception = exception,
    timeStart = timeStart,
    logger = logger
)