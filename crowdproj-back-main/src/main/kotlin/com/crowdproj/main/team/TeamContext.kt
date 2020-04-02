package com.crowdproj.main.team

import com.crowdproj.main.common.ContextStatuses
import com.crowdproj.main.common.IMainError
import com.crowdproj.main.common.KonveyorEnvironment
import com.crowdproj.main.team.models.TeamModel
import com.crowdproj.main.team.models.TeamQuery

data class TeamContext(
    var query: TeamQuery = TeamQuery.EMPTY,
    var requestTeamId: String = "",

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
