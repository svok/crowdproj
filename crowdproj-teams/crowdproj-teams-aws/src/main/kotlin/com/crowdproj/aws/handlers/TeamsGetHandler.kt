package com.crowdproj.aws.handlers

import com.crowdproj.rest.teams.models.RestQueryTeamGet
import com.crowdproj.teams.main.TeamContext
import com.crowdproj.teams.main.TeamsGetService
import com.crowdproj.teams.storage.dynamodb.DynamoDbTeamsStorage

class TeamsGetHandler: TeamsBaseHandler<RestQueryTeamGet, TeamsGetRequestContext>() {
    override suspend fun handleRequest(context: TeamsGetRequestContext, iContext: TeamContext) {
        val service = TeamsGetService(
            storage = DynamoDbTeamsStorage(context.logger)
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
