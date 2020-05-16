package com.crowdproj.teams.back.transport.rest.common.models

import com.crowdproj.teams.back.common.models.TeamVisibility
import java.time.Instant

data class TeamModel(
    var id: String = "",
    var name: String = "",
    var summary: String = "",
    var description: String = "",
    var owner: ProfileModel = ProfileModel.NONE,
    var photoUrls: Set<String> = mutableSetOf(),
    var tags: Set<TagModel> = mutableSetOf(),
    var timeCreated: Instant = Instant.MIN,
    var cans: MutableSet<String> = mutableSetOf(),
    var visibility: TeamVisibility = TeamVisibility.none,
    var joinability: TeamJoinability = TeamJoinability.none,
    var status: TeamStatusEnum = TeamStatusEnum.none,
    var lock: String = ""
) {

    companion object {
        val NONE = TeamModel()
    }
}
