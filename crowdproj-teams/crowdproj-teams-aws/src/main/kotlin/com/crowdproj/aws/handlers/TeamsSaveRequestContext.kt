package com.crowdproj.aws.handlers

import com.crowdproj.aws.base.TeamsRequestContext
import com.crowdproj.rest.teams.models.ApiQueryTeamSave
import com.crowdproj.rest.teams.models.ApiResponseTeam
import java.time.Instant

data class TeamsSaveRequestContext(
    override var request: ApiQueryTeamSave = ApiQueryTeamSave(),
    override var response: ApiResponseTeam = ApiResponseTeam(),
    override var exception: Throwable? = null,
    override var timeStart: Instant = Instant.MIN
): TeamsRequestContext<ApiQueryTeamSave>(
    request = request,
    response = response,
    exception = exception,
    timeStart = timeStart
)