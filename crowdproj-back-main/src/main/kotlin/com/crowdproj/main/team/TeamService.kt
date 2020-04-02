package com.crowdproj.main.team

import codes.spectrum.konveyor.konveyor
import com.crowdproj.main.common.ContextStatuses
import com.crowdproj.main.common.KonveyorEnvironment
import com.crowdproj.main.team.errors.ErrorStorage

class TeamService(
    storage: ITeamStorage
) {
    private val environment = KonveyorEnvironment(
        storage = storage
    )

    suspend fun findTeams(context: TeamContext) {
        if (context.env == KonveyorEnvironment.EMPTY) {
            context.env = environment
        }
        findTeamsKonveyor.exec(context)
    }

    suspend fun getTeam(context: TeamContext) {
        if (context.env == KonveyorEnvironment.EMPTY) {
            context.env = environment
        }
        getTeamKonveyor.exec(context = context)
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
        }

        private val getTeamKonveyor = konveyor<TeamContext> {
            exec { status = ContextStatuses.processing }
            exec {
                try {
                    env.storage.get(requestTeamId)?.also { result.add(it) }
                } catch (e: Exception) {
                    addFatal(ErrorStorage(message = e.message ?: ""))
                }
            }
        }
    }
}