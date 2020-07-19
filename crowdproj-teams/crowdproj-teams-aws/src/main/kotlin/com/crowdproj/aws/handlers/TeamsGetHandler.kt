package com.crowdproj.aws.handlers

import com.crowdproj.rest.teams.models.RestQueryTeamGet
import com.crowdproj.teams.main.TeamContext
import com.crowdproj.teams.main.TeamsGetService

class TeamsGetHandler: TeamsBaseHandler<RestQueryTeamGet, TeamsGetRequestContext>() {
    override suspend fun handleRequest(context: TeamsGetRequestContext, iContext: TeamContext) {
        val service = TeamsGetService(
            storage = context.dbTeamsStorage
        )
        iContext.apply {
            requestTeamId = context.request.teamId ?: ""
        }
        service.exec(iContext)
    }

    companion object {
        const val requestResource = "/teams/get"
    }
}
