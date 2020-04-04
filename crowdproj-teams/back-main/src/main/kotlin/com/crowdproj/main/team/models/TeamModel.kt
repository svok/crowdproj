package com.crowdproj.main.team.models

import com.crowdproj.main.profile.ProfileModel
import com.crowdproj.main.tag.TagModel
import java.time.Instant

data class TeamModel(
    var id: String = "",
    var name: String = "",
    var summary: String = "",
    var description: String = "",
    var owner: ProfileModel = ProfileModel.NONE,
    var photoUrls: Set<String> = mutableSetOf(),
    var tags: Set<TagModel> = mutableSetOf(),
    var visibility: TeamVisibility = TeamVisibility.none,
    var joinability: TeamJoinability = TeamJoinability.none,
    var timeCreated: Instant = Instant.MIN,
    var lock: String = "",
    var status: TeamStatusEnum = TeamStatusEnum.none
) {

    companion object {
        val NONE = TeamModel()
    }
}
