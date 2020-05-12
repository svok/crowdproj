package com.crowdproj.teams.main.handlers

import codes.spectrum.konveyor.IKonveyorEnvironment
import codes.spectrum.konveyor.IKonveyorHandler
import com.crowdproj.teams.back.transport.rest.common.models.TeamRelations
import com.crowdproj.teams.main.TeamContext

object SolveRelationsHandler : IKonveyorHandler<TeamContext> {
    override suspend fun exec(context: TeamContext, env: IKonveyorEnvironment) {
        context.result.forEach {
            it.relations.addAll(TeamRelations.own.expandRelation())
        }
    }

    override fun match(context: TeamContext, env: IKonveyorEnvironment): Boolean = context.result.isNotEmpty()

}