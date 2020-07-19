package com.crowdproj.aws.handlers

import com.crowdproj.rest.teams.models.RestQueryTeamSave
import com.crowdproj.teams.back.transport.rest.common.models.TeamModel
import com.crowdproj.teams.back.transport.rest.toMain
import com.crowdproj.teams.main.TeamContext
import com.crowdproj.teams.main.TeamsUpdateService

class TeamsUpdateHandler: TeamsBaseHandler<RestQueryTeamSave, TeamsSaveRequestContext>() {
    override suspend fun handleRequest(context: TeamsSaveRequestContext, iContext: TeamContext) {
        val service = TeamsUpdateService(
            storage = context.dbTeamsStorage
        )
        iContext.apply {
            requestTeam = context.request.data?.toMain() ?: TeamModel.NONE
        }
        service.exec(iContext)
    }

    companion object {
        const val requestResource = "/teams/update"
    }
}
