package com.crowdproj.aws.handlers

import com.crowdproj.aws.base.RequestContext
import com.crowdproj.aws.base.TeamsAwsBaseHandler
import com.crowdproj.aws.base.TeamsRequestContext
import com.crowdproj.rest.teams.models.RestQueryTeamFind
import com.crowdproj.rest.teams.models.RestResponseTeam
import com.crowdproj.teams.back.transport.rest.toMain
import com.crowdproj.teams.main.TeamContext
import com.crowdproj.teams.main.TeamsFindService
import com.crowdproj.teams.storage.dynamodb.DynamoDbTeamsStorage

class TeamsIndexHandler: TeamsAwsBaseHandler<RestQueryTeamFind>(
    requestClass = RestQueryTeamFind::class.java
) {
    override fun createContext(): RequestContext<RestQueryTeamFind, RestResponseTeam> = TeamsIndexRequestContext()

    override suspend fun handler(oContext: TeamsRequestContext<RestQueryTeamFind>, iContext: TeamContext) {
        val service = TeamsFindService(
            storage = DynamoDbTeamsStorage(oContext.logger)
        )
        val request = oContext.request
        iContext.query = request.toMain()
        service.exec(iContext)
    }

}
