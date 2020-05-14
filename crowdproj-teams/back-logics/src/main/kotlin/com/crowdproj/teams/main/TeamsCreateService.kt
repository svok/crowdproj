package com.crowdproj.teams.main

import codes.spectrum.konveyor.konveyor
import com.crowdproj.common.ContextStatuses
import com.crowdproj.teams.main.common.KonveyorEnvironment
import com.crowdproj.teams.main.errors.ErrorStorage
import com.crowdproj.teams.main.exceptions.ErrorSavingToDb
import com.crowdproj.teams.storage.common.ITeamStorage

class TeamsCreateService(
    storage: ITeamStorage
): ITeamsService {
    private val environment = KonveyorEnvironment(
        storage = storage
    )

    override suspend fun exec(context: TeamContext) {
        if (context.env == KonveyorEnvironment.EMPTY) {
            context.env = environment
        }
        createTeamKonveyor.exec(context = context)
    }

    companion object {
        private val createTeamKonveyor = konveyor<TeamContext> {
            exec { status = ContextStatuses.processing }
            exec {
                try {
                    val savedTeam = env.storage.create(requestTeam) ?: throw ErrorSavingToDb("ErrorSaving")
                    result.add(savedTeam)
                } catch (e: Exception) {
                    addFatal(ErrorStorage(message = e.message ?: ""))
                }
            }
        }
    }
}
