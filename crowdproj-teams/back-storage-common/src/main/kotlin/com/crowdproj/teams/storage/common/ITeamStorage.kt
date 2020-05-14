package com.crowdproj.teams.storage.common

import com.crowdproj.teams.back.transport.rest.common.models.TeamFindQuery
import com.crowdproj.teams.back.transport.rest.common.models.TeamModel


interface ITeamStorage {
    suspend fun findTeams(query: TeamFindQuery): Sequence<TeamModel>
    suspend fun create(team: TeamModel): TeamModel?
    suspend fun update(team: TeamModel): TeamModel?
    suspend fun get(teamId: String): TeamModel?

    companion object {
        val EMPTY = object : ITeamStorage {
            override suspend fun findTeams(query: TeamFindQuery): Sequence<TeamModel> {
                TODO("Not yet implemented")
            }

            override suspend fun create(team: TeamModel): TeamModel? {
                TODO("Not yet implemented")
            }

            override suspend fun update(team: TeamModel): TeamModel? {
                TODO("Not yet implemented")
            }

            override suspend fun get(teamId: String): TeamModel? {
                TODO("Not yet implemented")
            }

        }
    }
}
