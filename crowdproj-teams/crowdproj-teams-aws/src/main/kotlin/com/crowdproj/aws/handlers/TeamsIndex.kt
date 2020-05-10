package com.crowdproj.aws.handlers

import com.crowdproj.aws.base.RequestContext
import com.crowdproj.aws.base.TeamsAwsBaseHandler
import com.crowdproj.aws.base.TeamsRequestContext
import com.crowdproj.ktor.storage.toMain
import com.crowdproj.main.team.TeamContext
import com.crowdproj.rest.teams.models.ApiQueryTeamFind
import com.crowdproj.rest.teams.models.ApiResponseTeam

class TeamsIndexHandler: TeamsAwsBaseHandler<ApiQueryTeamFind>(
    requestClass = ApiQueryTeamFind::class.java
) {
    override fun createContext(): RequestContext<ApiQueryTeamFind, ApiResponseTeam> = TeamsIndexRequestContext()

    override suspend fun handler(oContext: TeamsRequestContext<ApiQueryTeamFind>, iContext: TeamContext) {
        val request = oContext.request
        iContext.query = request.toMain()
        service.findTeams(iContext)
    }

}
