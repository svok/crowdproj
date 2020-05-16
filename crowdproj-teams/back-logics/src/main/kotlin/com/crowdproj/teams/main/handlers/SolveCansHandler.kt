package com.crowdproj.teams.main.handlers

import codes.spectrum.konveyor.IKonveyorEnvironment
import codes.spectrum.konveyor.IKonveyorHandler
import com.crowdproj.teams.back.transport.rest.common.models.TeamOperations
import com.crowdproj.teams.back.transport.rest.common.models.TeamRelations
import com.crowdproj.teams.main.TeamContext

object SolveCansHandler : IKonveyorHandler<TeamContext> {
    override suspend fun exec(context: TeamContext, env: IKonveyorEnvironment) {
        context.result.forEach {
            it.cans = mutableSetOf(
                TeamOperations.ACCEPT_INVITATION,
                TeamOperations.APPLY,
                TeamOperations.DENY_INVITATION,
                TeamOperations.INVITE,
                TeamOperations.INVITE,
                TeamOperations.JOIN,
                TeamOperations.LEAVE,
                TeamOperations.UNAPPLY,
                TeamOperations.UPDATE
            )
        }
    }

    override fun match(context: TeamContext, env: IKonveyorEnvironment): Boolean = context.result.isNotEmpty()

}