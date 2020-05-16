package com.crowdproj.teams.main

import codes.spectrum.konveyor.konveyor
import com.crowdproj.common.ContextStatuses
import com.crowdproj.teams.main.common.KonveyorEnvironment
import com.crowdproj.teams.main.errors.ErrorStorage
import com.crowdproj.teams.main.exceptions.ErrorSavingToDb
import com.crowdproj.teams.main.handlers.SolveCansHandler
import com.crowdproj.teams.storage.common.ITeamStorage

class TeamsFindService(
    storage: ITeamStorage
): ITeamsService {
    private val environment = KonveyorEnvironment(
        storage = storage
    )

    override suspend fun exec(context: TeamContext) {
        if (context.env == KonveyorEnvironment.EMPTY) {
            context.env = environment
        }
        findTeamsKonveyor.exec(context)
    }

    companion object {
        private val findTeamsKonveyor = konveyor<TeamContext> {
            exec { status = ContextStatuses.processing }
            exec {
                try {
                    result = env.storage.findTeams(query).toMutableList()
                } catch (e: Exception) {
                    addFatal(ErrorStorage(message = e.message ?: ""))
                }
            }
            + SolveCansHandler
        }
    }
}
