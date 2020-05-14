package com.crowdproj.teams.main

import codes.spectrum.konveyor.konveyor
import com.crowdproj.common.ContextStatuses
import com.crowdproj.teams.main.common.KonveyorEnvironment
import com.crowdproj.teams.main.errors.ErrorStorage
import com.crowdproj.teams.main.exceptions.ErrorSavingToDb
import com.crowdproj.teams.storage.common.ITeamStorage

class TeamService(
    storage: ITeamStorage
) {
    private val getService = TeamsGetService(storage)
    private val createService = TeamsCreateService(storage)
    private val updateService = TeamsUpdateService(storage)
    private val findService = TeamsFindService(storage)

    private suspend fun exec(context: TeamContext, service: ITeamsService) {
        service.exec(context)
    }

    suspend fun findTeams(context: TeamContext) = exec(context, findService)

    suspend fun getTeam(context: TeamContext) = exec(context, getService)

    suspend fun createTeam(context: TeamContext) = exec(context, createService)

    suspend fun updateTeam(context: TeamContext) = exec(context, updateService)
}
