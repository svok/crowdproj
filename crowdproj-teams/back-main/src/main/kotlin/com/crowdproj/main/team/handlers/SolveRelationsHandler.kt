package com.crowdproj.main.team.handlers

import codes.spectrum.konveyor.IKonveyorEnvironment
import codes.spectrum.konveyor.IKonveyorHandler
import com.crowdproj.main.team.TeamContext
import com.crowdproj.main.team.models.TeamRelations

object SolveRelationsHandler : IKonveyorHandler<TeamContext> {
    override suspend fun exec(context: TeamContext, env: IKonveyorEnvironment) {
        context.result.forEach {
            it.relations.addAll(TeamRelations.own.expandRelation())
        }
    }

    override fun match(context: TeamContext, env: IKonveyorEnvironment): Boolean = context.result.isNotEmpty()

}