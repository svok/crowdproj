package com.crowdproj.teams.back.transport.rest

import com.crowdproj.rest.teams.models.*
import com.crowdproj.teams.back.common.models.*
import com.crowdproj.teams.back.transport.rest.common.models.*
import com.crowdproj.teams.back.transport.rest.common.models.TeamFindQuery.Companion.DEFAULT_TEAMS_LIMIT


fun RestTeam.toMain() = TeamModel(
    id = id ?: "",
    name = name,
    summary = summary,
    description = description ?: "",
    owner = owner?.toMain() ?: ProfileModel.NONE,
    photoUrls = photoUrls?.toSet() ?: mutableSetOf(),
    tags = tags?.map { it.toMain() }?.toSet() ?: setOf(),
    visibility = visibility.toMain(),
    joinability = joinability.toMain(),
    status = status.toMain(),
    cans = cans?.map { it.toMain() }?.toMutableSet() ?: mutableSetOf()
)

fun Collection<TeamModel>.toApiResults() = this.map { it.toApi() }

fun RestTeamVisibility?.toMain() = when (this) {
    null -> TeamVisibility.none
    RestTeamVisibility.teamPublic -> TeamVisibility.public
    RestTeamVisibility.teamGroupOnly -> TeamVisibility.groupOnly
    RestTeamVisibility.teamMembersOnly -> TeamVisibility.membersOnly
    RestTeamVisibility.teamRegisteredOnly -> TeamVisibility.registeredOnly
}

fun RestTeamJoinability?.toMain() = when (this) {
    null -> TeamJoinability.none
    RestTeamJoinability.byMember -> TeamJoinability.byMember
    RestTeamJoinability.byOwner -> TeamJoinability.byOwner
    RestTeamJoinability.byUser -> TeamJoinability.byUser
}

fun RestTeamStatus?.toMain() = when (this) {
    null -> TeamStatusEnum.none
    RestTeamStatus.active -> TeamStatusEnum.active
    RestTeamStatus.deleted -> TeamStatusEnum.deleted
    RestTeamStatus.pending -> TeamStatusEnum.pending
    RestTeamStatus.closed -> TeamStatusEnum.closed
}

fun TeamModel.toApi() = RestTeam(
    id = id.takeIf { it.isNotBlank() },
    name = name,
    summary = summary,
    description = description.takeIf { it.isNotBlank() },
    owner = owner.takeIf { it != ProfileModel.NONE }?.toApi(),
    photoUrls = photoUrls.takeIf { it.isNotEmpty() }?.toTypedArray(),
    tags = tags.takeIf { it.isNotEmpty() }?.toApiTags()?.toTypedArray(),
    cans = cans.takeIf { it.isNotEmpty() }?.map { it.toApi() }?.toMutableSet(),
    visibility = visibility.toApi(),
    joinability = joinability.toApi(),
    status = status.toApi()
)

fun TeamOperations.toApi(): RestTeamOperations = when(this) {
    TeamOperations.ACCEPT_INVITATION -> RestTeamOperations.acceptInvitation
    TeamOperations.UPDATE -> RestTeamOperations.update
    TeamOperations.UNAPPLY -> RestTeamOperations.unapply
    TeamOperations.LEAVE -> RestTeamOperations.leave
    TeamOperations.JOIN -> RestTeamOperations.join
    TeamOperations.INVITE -> RestTeamOperations.invite
    TeamOperations.DENY_INVITATION -> RestTeamOperations.cancelInvitation
    TeamOperations.APPLY -> RestTeamOperations.apply
}

fun RestTeamOperations.toMain(): TeamOperations = when(this) {
    RestTeamOperations.acceptInvitation -> TeamOperations.ACCEPT_INVITATION
    RestTeamOperations.update -> TeamOperations.UPDATE
    RestTeamOperations.unapply -> TeamOperations.UNAPPLY
    RestTeamOperations.leave -> TeamOperations.LEAVE
    RestTeamOperations.join -> TeamOperations.JOIN
    RestTeamOperations.invite -> TeamOperations.INVITE
    RestTeamOperations.cancelInvitation -> TeamOperations.DENY_INVITATION
    RestTeamOperations.apply -> TeamOperations.APPLY
}

private fun TeamJoinability.toApi(): RestTeamJoinability? = when(this) {
    TeamJoinability.byMember -> RestTeamJoinability.byMember
    TeamJoinability.byOwner -> RestTeamJoinability.byOwner
    TeamJoinability.byUser -> RestTeamJoinability.byUser
    TeamJoinability.none -> null
}

fun TeamVisibility.toApi(): RestTeamVisibility? = when (this) {
    TeamVisibility.none -> null
    TeamVisibility.public -> RestTeamVisibility.teamPublic
    TeamVisibility.groupOnly -> RestTeamVisibility.teamGroupOnly
    TeamVisibility.membersOnly -> RestTeamVisibility.teamMembersOnly
    TeamVisibility.registeredOnly -> RestTeamVisibility.teamRegisteredOnly
}

fun TeamStatusEnum.toApi(): RestTeamStatus? = when (this) {
    TeamStatusEnum.none -> null
    TeamStatusEnum.active -> RestTeamStatus.active
    TeamStatusEnum.deleted -> RestTeamStatus.deleted
    TeamStatusEnum.pending -> RestTeamStatus.pending
    TeamStatusEnum.closed -> RestTeamStatus.closed
}

fun TeamSaveQuery.Companion.from(query: RestQueryTeamSave) =
    TeamSaveQuery(
        team = query.data?.toMain()
            ?: TeamModel.NONE
    )

fun RestQueryTeamFind?.toMain() = if (this == null) TeamFindQuery.EMPTY
else TeamFindQuery(
    offset = offset ?: 0L,
    limit = limit ?: DEFAULT_TEAMS_LIMIT
)