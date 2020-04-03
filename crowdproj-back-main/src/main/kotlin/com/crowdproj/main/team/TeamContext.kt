package com.crowdproj.main.team

import com.crowdproj.main.common.ContextStatuses
import com.crowdproj.main.common.IMainError
import com.crowdproj.main.common.KonveyorEnvironment
import com.crowdproj.main.team.models.TeamModel
import com.crowdproj.main.team.models.TeamFindQuery

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
