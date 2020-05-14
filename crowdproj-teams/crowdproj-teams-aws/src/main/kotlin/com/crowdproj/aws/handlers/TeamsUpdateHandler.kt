package com.crowdproj.aws.handlers

import com.crowdproj.aws.base.RequestContext
import com.crowdproj.aws.base.TeamsAwsBaseHandler
import com.crowdproj.aws.base.TeamsRequestContext
import com.crowdproj.teams.main.TeamContext
import com.crowdproj.rest.teams.models.ApiQueryTeamSave
import com.crowdproj.rest.teams.models.ApiResponseTeam
import com.crowdproj.teams.back.transport.rest.common.models.TeamModel
import com.crowdproj.teams.back.transport.rest.toMain
import com.crowdproj.teams.main.TeamsUpdateService
import com.crowdproj.teams.storage.dynamodb.DynamoDbTeamsStorage

class TeamsUpdateHandler: TeamsAwsBaseHandler<ApiQueryTeamSave>(
    requestClass = ApiQueryTeamSave::class.java
) {
    override fun createContext(): RequestContext<ApiQueryTeamSave, ApiResponseTeam> = TeamsSaveRequestContext()

    override suspend fun handler(oContext: TeamsRequestContext<ApiQueryTeamSave>, iContext: TeamContext) {
        val service = TeamsUpdateService(
            storage = DynamoDbTeamsStorage(oContext.logger)
        )
        val request = oContext.request
        iContext.requestTeam = request.data?.toMain() ?: TeamModel.NONE
        service.exec(iContext)
    }

}
