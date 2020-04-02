package com.crowdproj.main.common

import com.crowdproj.main.team.ITeamStorage

data class KonveyorEnvironment(
    val storage: ITeamStorage = ITeamStorage.EMPTY
) {

    companion object {
        val EMPTY = KonveyorEnvironment()
    }
}
