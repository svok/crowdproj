package com.crowdproj.aws.handlers

import com.crowdproj.aws.base.RequestContext
import com.crowdproj.rest.teams.models.ApiQueryTeamFind
import com.crowdproj.rest.teams.models.ApiQueryTeamGet
import com.crowdproj.rest.teams.models.ApiResponseTeam
import java.time.Instant

data class TeamsGetRequestContext(
    override var request: ApiQueryTeamGet = ApiQueryTeamGet(),
    override var response: ApiResponseTeam = ApiResponseTeam(),
    override var exception: Throwable? = null,
    override var timeStart: Instant = Instant.MIN
): RequestContext<ApiQueryTeamGet, ApiResponseTeam>(
    request = request,
    response = response,
    exception = exception,
    timeStart = timeStart
)