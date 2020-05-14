package com.crowdproj.teams.main

import codes.spectrum.konveyor.konveyor
import com.crowdproj.common.ContextStatuses
import com.crowdproj.teams.main.common.KonveyorEnvironment
import com.crowdproj.teams.main.errors.ErrorStorage
import com.crowdproj.teams.main.exceptions.ErrorSavingToDb
import com.crowdproj.teams.storage.common.ITeamStorage

class TeamsUpdateService(
    storage: ITeamStorage
): ITeamsService {
    private val environment = KonveyorEnvironment(
        storage = storage
    )

    override suspend fun exec(context: TeamContext) {
        if (context.env == KonveyorEnvironment.EMPTY) {
            context.env = environment
        }
        updateTeamKonveyor.exec(context = context)
    }

    companion object {
        private val updateTeamKonveyor = konveyor<TeamContext> {
            exec { status = ContextStatuses.processing }
            exec {
                try {
                    val savedTeam = env.storage.update(requestTeam) ?: throw ErrorSavingToDb("ErrorSaving")
                    result.add(savedTeam)
                } catch (e: Exception) {
                    addFatal(ErrorStorage(message = e.message ?: ""))
                }
            }
        }
    }
}
