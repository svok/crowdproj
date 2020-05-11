package com.crowdproj.aws.handlers

import com.crowdproj.aws.base.TeamsRequestContext
import com.crowdproj.rest.teams.models.ApiQueryTeamFind
import com.crowdproj.rest.teams.models.ApiResponseTeam
import java.time.Instant

data class TeamsIndexRequestContext(
    override var request: ApiQueryTeamFind = ApiQueryTeamFind(),
    override var response: ApiResponseTeam = ApiResponseTeam(),
    override var exception: Throwable? = null,
    override var timeStart: Instant = Instant.MIN
): TeamsRequestContext<ApiQueryTeamFind>(
    request = request,
    response = response,
    exception = exception,
    timeStart = timeStart
)