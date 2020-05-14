package com.crowdproj.aws.handlers

import com.crowdproj.aws.base.RequestContext
import com.crowdproj.aws.base.TeamsAwsBaseHandler
import com.crowdproj.aws.base.TeamsRequestContext
import com.crowdproj.rest.teams.models.ApiQueryTeamFind
import com.crowdproj.rest.teams.models.ApiResponseTeam
import com.crowdproj.teams.back.transport.rest.toMain
import com.crowdproj.teams.main.TeamContext
import com.crowdproj.teams.main.TeamsFindService
import com.crowdproj.teams.storage.dynamodb.DynamoDbTeamsStorage

class TeamsIndexHandler: TeamsAwsBaseHandler<ApiQueryTeamFind>(
    requestClass = ApiQueryTeamFind::class.java
) {
    override fun createContext(): RequestContext<ApiQueryTeamFind, ApiResponseTeam> = TeamsIndexRequestContext()

    override suspend fun handler(oContext: TeamsRequestContext<ApiQueryTeamFind>, iContext: TeamContext) {
        val service = TeamsFindService(
            storage = DynamoDbTeamsStorage(oContext.logger)
        )
        val request = oContext.request
        iContext.query = request.toMain()
        service.exec(iContext)
    }

}
