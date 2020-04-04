package com.crowdproj.main.team

import com.crowdproj.main.team.models.TeamModel
import com.crowdproj.main.team.models.TeamFindQuery

interface ITeamStorage {
    suspend fun findTeams(query: TeamFindQuery): Sequence<TeamModel>
    suspend fun create(team: TeamModel): String
    suspend fun update(team: TeamModel)
    suspend fun get(teamId: String): TeamModel?

    companion object {
        val EMPTY = object : ITeamStorage {
            override suspend fun findTeams(query: TeamFindQuery): Sequence<TeamModel> {
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
