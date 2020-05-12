package com.crowdproj.teams.back.transport.rest.common.models

data class TeamSaveQuery(
    val team: TeamModel = TeamModel.NONE
) {
    companion object {
        val EMPTY = TeamSaveQuery()
    }
}
