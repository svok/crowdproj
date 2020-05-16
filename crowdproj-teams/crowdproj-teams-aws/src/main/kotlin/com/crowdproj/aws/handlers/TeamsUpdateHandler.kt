package com.crowdproj.aws.handlers

import com.crowdproj.aws.base.RequestContext
import com.crowdproj.aws.base.TeamsAwsBaseHandler
import com.crowdproj.aws.base.TeamsRequestContext
import com.crowdproj.teams.main.TeamContext
import com.crowdproj.rest.teams.models.RestQueryTeamSave
import com.crowdproj.rest.teams.models.RestResponseTeam
import com.crowdproj.teams.back.transport.rest.common.models.TeamModel
import com.crowdproj.teams.back.transport.rest.toMain
import com.crowdproj.teams.main.TeamsUpdateService
import com.crowdproj.teams.storage.dynamodb.DynamoDbTeamsStorage

class TeamsUpdateHandler: TeamsAwsBaseHandler<RestQueryTeamSave>(
    requestClass = RestQueryTeamSave::class.java
) {
    override fun createContext(): RequestContext<RestQueryTeamSave, RestResponseTeam> = TeamsSaveRequestContext()

    override suspend fun handler(oContext: TeamsRequestContext<RestQueryTeamSave>, iContext: TeamContext) {
        val service = TeamsUpdateService(
            storage = DynamoDbTeamsStorage(oContext.logger)
        )
        val request = oContext.request
        iContext.requestTeam = request.data?.toMain() ?: TeamModel.NONE
        service.exec(iContext)
    }

}
