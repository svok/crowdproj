package com.crowdproj.aws.handlers

import com.crowdproj.aws.base.RequestContext
import com.crowdproj.aws.base.TeamsAwsBaseHandler
import com.crowdproj.aws.base.TeamsRequestContext
import com.crowdproj.aws.storage.toMain
import com.crowdproj.main.team.TeamContext
import com.crowdproj.main.team.models.TeamModel
import com.crowdproj.rest.teams.models.ApiQueryTeamSave
import com.crowdproj.rest.teams.models.ApiResponseTeam

class TeamsCreateHandler: TeamsAwsBaseHandler<ApiQueryTeamSave>(
    requestClass = ApiQueryTeamSave::class.java
) {
    override fun createContext(): RequestContext<ApiQueryTeamSave, ApiResponseTeam> = TeamsSaveRequestContext()

    override suspend fun handler(oContext: TeamsRequestContext<ApiQueryTeamSave>, iContext: TeamContext) {
        val request = oContext.request
        iContext.requestTeam = request.data?.toMain() ?: TeamModel.NONE
        service.createTeam(iContext)
    }

}
