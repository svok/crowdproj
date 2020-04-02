package com.crowdproj.main.team

import com.crowdproj.main.team.models.TeamModel
import com.crowdproj.main.team.models.TeamQuery

interface ITeamStorage {
    suspend fun findTeams(query: TeamQuery): Sequence<TeamModel>
    suspend fun create(team: TeamModel): String
    suspend fun update(team: TeamModel)
    suspend fun get(teamId: String): TeamModel?

    companion object {
        val EMPTY = object : ITeamStorage {
            override suspend fun findTeams(query: TeamQuery): Sequence<TeamModel> {
                TODO("Not yet implemented")
            }

            override suspend fun create(team: TeamModel): String {
                TODO("Not yet implemented")
            }

            override suspend fun update(team: TeamModel) {
                TODO("Not yet implemented")
            }

            override suspend fun get(teamId: String): TeamModel? {
                TODO("Not yet implemented")
            }

        }
    }
}
