package com.crowdproj.main.team.models

data class TeamSaveQuery(
    val team: TeamModel = TeamModel.NONE
) {
    companion object {
        val EMPTY = TeamSaveQuery()
    }
}
