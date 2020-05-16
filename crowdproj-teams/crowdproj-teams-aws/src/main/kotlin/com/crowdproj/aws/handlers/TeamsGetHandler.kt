package com.crowdproj.aws.handlers

import com.crowdproj.aws.base.RequestContext
import com.crowdproj.aws.base.TeamsAwsBaseHandler
import com.crowdproj.aws.base.TeamsRequestContext
import com.crowdproj.teams.main.TeamContext
import com.crowdproj.rest.teams.models.RestQueryTeamGet
import com.crowdproj.rest.teams.models.RestResponseTeam
import com.crowdproj.teams.main.TeamsGetService
import com.crowdproj.teams.storage.dynamodb.DynamoDbTeamsStorage

class TeamsGetHandler: TeamsAwsBaseHandler<RestQueryTeamGet>(
    requestClass = RestQueryTeamGet::class.java
) {
    override fun createContext(): RequestContext<RestQueryTeamGet, RestResponseTeam> = TeamsGetRequestContext()

    override suspend fun handler(oContext: TeamsRequestContext<RestQueryTeamGet>, iContext: TeamContext) {
        val service = TeamsGetService(
            storage = DynamoDbTeamsStorage(oContext.logger)
        )
        val request = oContext.request
        iContext.requestTeamId = request.teamId ?: ""
        service.exec(iContext)
    }

}
