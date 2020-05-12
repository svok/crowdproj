package com.crowdproj.teams.main

import com.crowdproj.common.ContextStatuses
import com.crowdproj.common.IMainError
import com.crowdproj.teams.back.transport.rest.common.models.TeamFindQuery
import com.crowdproj.teams.back.transport.rest.common.models.TeamModel
import com.crowdproj.teams.main.common.KonveyorEnvironment

data class TeamContext(
    var query: TeamFindQuery = TeamFindQuery.EMPTY,
    var requestTeamId: String = "",
    var requestTeam: TeamModel = TeamModel.NONE,

    var result: MutableList<TeamModel> = mutableListOf(),
    var errors: MutableList<IMainError> = mutableListOf(),

    var status: ContextStatuses = ContextStatuses.none,
    var env: KonveyorEnvironment = KonveyorEnvironment.EMPTY
) {
    fun addFatal(error: IMainError) {
        addError(error)
        status = ContextStatuses.failing
    }
    fun addError(error: IMainError) {
        errors.add(error)
    }
}
