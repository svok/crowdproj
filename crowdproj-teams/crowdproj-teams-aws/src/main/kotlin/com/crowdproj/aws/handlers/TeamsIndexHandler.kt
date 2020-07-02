package com.crowdproj.aws.handlers

import com.crowdproj.rest.teams.models.RestQueryTeamFind
import com.crowdproj.teams.back.transport.rest.toMain
import com.crowdproj.teams.main.TeamContext
import com.crowdproj.teams.main.TeamsFindService
import com.crowdproj.teams.storage.dynamodb.DynamoDbTeamsStorage

class TeamsIndexHandler: TeamsBaseHandler<RestQueryTeamFind, TeamsIndexRequestContext>() {
    override suspend fun handleRequest(context: TeamsIndexRequestContext, iContext: TeamContext) {
        val service = TeamsFindService(
            storage = DynamoDbTeamsStorage(context.logger)
        )
        val request = context.request
        iContext.query = request.toMain()
        service.exec(iContext)
    }

    companion object {
        const val requestResource = "/teams/index"
    }
}
