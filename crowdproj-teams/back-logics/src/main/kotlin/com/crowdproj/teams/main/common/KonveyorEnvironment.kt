package com.crowdproj.teams.main.common

import com.crowdproj.teams.storage.common.ITeamStorage


data class KonveyorEnvironment(
    val storage: ITeamStorage = ITeamStorage.EMPTY
) {

    companion object {
        val EMPTY = KonveyorEnvironment()
    }
}
