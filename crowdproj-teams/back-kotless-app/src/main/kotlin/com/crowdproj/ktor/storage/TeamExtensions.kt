package com.crowdproj.ktor.storage

import com.amazonaws.services.dynamodbv2.document.Item
import com.crowdproj.ktor.teams.storage.tag.toApiTags
import com.crowdproj.ktor.teams.storage.tag.toMain
import com.crowdproj.main.profile.ProfileModel
import com.crowdproj.main.tag.TagModel
import com.crowdproj.main.team.models.*
import com.crowdproj.rest.teams.models.ApiQueryTeamFind
import com.crowdproj.rest.teams.models.ApiQueryTeamSave
import com.crowdproj.rest.teams.models.Team
import com.crowdproj.rest.teams.models.TeamStatus
import com.crowdproj.rest.teams.models.TeamVisibility as ApiTeamVisibility
import com.crowdproj.rest.teams.models.TeamJoinability as ApiTeamJoinability


fun TeamModel.toItem() = Item()
    .apply { if (id.isNotBlank()) withPrimaryKey("id", id) }
    .apply { if (name.isNotBlank()) withString("name", name) }
    .apply { if (summary.isNotBlank()) withString("summary", summary) }
    .apply { if (description.isNotBlank()) withString("description", description) }
    .apply { if (owner.id.isNotBlank()) withString("ownerId", owner.id) }
    .apply { if (photoUrls.isNotEmpty()) withStringSet("phoroUrls", photoUrls) }
    .apply { if (tags.isNotEmpty()) withStringSet("tagIds", tags.map { it.id }.toSet()) }
    .apply { if (visibility != TeamVisibility.none) withString("visibility", visibility.toString()) }
    .apply { if (joinability != TeamJoinability.none) withString("joinability", joinability.toString()) }
    .apply { if (status != TeamStatusEnum.none) withString("status", status.toString()) }

fun TeamModel.Companion.from(item: Item) = TeamModel(
    id = item.getString("id") ?: "",
    name = item.getString("name") ?: "",
    summary = item.getString("summary") ?: "",
    description = item.getString("description") ?: "",
    owner = item.getString("ownerId")
        ?.let { ProfileModel(id = it) }
        ?: ProfileModel.NONE,
    photoUrls = item.getStringSet("photoUrls") ?: mutableSetOf(),
    tags = item.getStringSet("tagIds")
        ?.asSequence()
        ?.map { TagModel(id = it) }
        ?.toMutableSet()
        ?: mutableSetOf(),
    visibility = TeamVisibility.valueOf(item.getString("visibility") ?: "none"),
    joinability = TeamJoinability.valueOf(item.getString("joinability") ?: "none"),
    status = TeamStatusEnum.valueOf(item.getString("status") ?: "none")
)

fun Team.toMain() = TeamModel(
    id = id ?: "",
    name = name ?: "",
    summary = summary ?: "",
    description = description ?: "",
    owner = owner.toMain(),
    photoUrls = photoUrls?.toSet() ?: mutableSetOf(),
    tags = tags?.map { it.toMain() }?.toSet() ?: setOf(),
    visibility = visibility.toMain(),
    joinability = joinability.toMain(),
    status = status.toMain()
)

fun Collection<TeamModel>.toApiResults() = this.map { it.toApiResult() }

fun ApiTeamVisibility?.toMain() = when (this) {
    null -> TeamVisibility.none
    ApiTeamVisibility.teamPublic -> TeamVisibility.public
    ApiTeamVisibility.teamGroupOnly -> TeamVisibility.groupOnly
    ApiTeamVisibility.teamMembersOnly -> TeamVisibility.membersOnly
    ApiTeamVisibility.teamRegisteredOnly -> TeamVisibility.registeredOnly
}

fun ApiTeamJoinability?.toMain() = when (this) {
    null -> TeamJoinability.none
    ApiTeamJoinability.byMember -> TeamJoinability.byMember
    ApiTeamJoinability.byOwner -> TeamJoinability.byOwner
    ApiTeamJoinability.byUser -> TeamJoinability.byUser
}

fun TeamStatus?.toMain() = when (this) {
    null -> TeamStatusEnum.none
    TeamStatus.active -> TeamStatusEnum.active
    TeamStatus.deleted -> TeamStatusEnum.deleted
    TeamStatus.pending -> TeamStatusEnum.pending
    TeamStatus.closed -> TeamStatusEnum.closed
}

fun TeamModel.toApiResult() = Team(
    id = id.takeIf { it.isNotBlank() },
    name = name,
    summary = summary,
    description = description.takeIf { it.isNotBlank() },
    owner = owner.toApiProfile(),
    photoUrls = photoUrls.toTypedArray(),
    tags = tags.toApiTags().toTypedArray(),
    visibility = visibility.toApiTeamVisibility()
)

fun TeamVisibility.toApiTeamVisibility(): ApiTeamVisibility? = when (this) {
    TeamVisibility.none -> null
    TeamVisibility.public -> ApiTeamVisibility.teamPublic
    TeamVisibility.groupOnly -> ApiTeamVisibility.teamGroupOnly
    TeamVisibility.membersOnly -> ApiTeamVisibility.teamMembersOnly
    TeamVisibility.registeredOnly -> ApiTeamVisibility.teamRegisteredOnly
}

fun TeamFindQuery.Companion.from(query: ApiQueryTeamFind) = TeamFindQuery(
    tagIds = query.tagIds?.toSet() ?: emptySet()
)

fun TeamSaveQuery.Companion.from(query: ApiQueryTeamSave) = TeamSaveQuery(
    team = query.data?.toMain() ?: TeamModel.NONE
)
