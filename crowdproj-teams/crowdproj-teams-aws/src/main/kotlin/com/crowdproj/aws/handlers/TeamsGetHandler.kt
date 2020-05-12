package com.crowdproj.aws.handlers

import com.crowdproj.aws.base.RequestContext
import com.crowdproj.aws.base.TeamsAwsBaseHandler
import com.crowdproj.aws.base.TeamsRequestContext
import com.crowdproj.teams.main.TeamContext
import com.crowdproj.rest.teams.models.ApiQueryTeamGet
import com.crowdproj.rest.teams.models.ApiResponseTeam

class TeamsGetHandler: TeamsAwsBaseHandler<ApiQueryTeamGet>(
    requestClass = ApiQueryTeamGet::class.java
) {
    override fun createContext(): RequestContext<ApiQueryTeamGet, ApiResponseTeam> = TeamsGetRequestContext()

    override suspend fun handler(oContext: TeamsRequestContext<ApiQueryTeamGet>, iContext: TeamContext) {
        val request = oContext.request
        iContext.requestTeamId = request.teamId ?: ""
        service.getTeam(iContext)
    }

}
