package com.crowdproj.main.team

import codes.spectrum.konveyor.konveyor
import com.crowdproj.common.ContextStatuses
import com.crowdproj.main.team.common.KonveyorEnvironment
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

    suspend fun createTeam(context: TeamContext) {
        if (context.env == KonveyorEnvironment.EMPTY) {
            context.env = environment
        }
        createTeamKonveyor.exec(context = context)
    }

    suspend fun updateTeam(context: TeamContext) {
        if (context.env == KonveyorEnvironment.EMPTY) {
            context.env = environment
        }
        updateTeamKonveyor.exec(context = context)
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
        private val createTeamKonveyor = konveyor<TeamContext> {
            exec { status = ContextStatuses.processing }
            exec {
                try {
                    val id = env.storage.create(requestTeam)
                    result.add(requestTeam.copy(id = id))
                } catch (e: Exception) {
                    addFatal(ErrorStorage(message = e.message ?: ""))
                }
            }
        }
        private val updateTeamKonveyor = konveyor<TeamContext> {
            exec { status = ContextStatuses.processing }
            exec {
                try {
                    env.storage.update(requestTeam)
                    result.add(requestTeam.copy())
                } catch (e: Exception) {
                    addFatal(ErrorStorage(message = e.message ?: ""))
                }
            }
        }
    }
}
