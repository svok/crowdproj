package com.crowdproj.teams.back.transport.rest

import com.crowdproj.rest.teams.models.ApiQueryTeamFind
import com.crowdproj.rest.teams.models.ApiQueryTeamSave
import com.crowdproj.rest.teams.models.Team
import com.crowdproj.rest.teams.models.TeamStatus
import com.crowdproj.teams.back.common.models.*
import com.crowdproj.teams.back.transport.rest.common.models.*
import com.crowdproj.teams.back.transport.rest.common.models.TeamFindQuery.Companion.DEFAULT_TEAMS_LIMIT

import com.crowdproj.rest.teams.models.TeamStatus as ApiTeamStatus
import com.crowdproj.rest.teams.models.TeamVisibility as ApiTeamVisibility
import com.crowdproj.rest.teams.models.TeamJoinability as ApiTeamJoinability


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
    photoUrls = photoUrls.takeIf { it.isNotEmpty() }?.toTypedArray(),
    tags = tags.takeIf { it.isNotEmpty() }?.toApiTags()?.toTypedArray(),
    visibility = visibility.toApiTeamVisibility()
)

fun TeamVisibility.toApiTeamVisibility(): ApiTeamVisibility? = when (this) {
    TeamVisibility.none -> null
    TeamVisibility.public -> ApiTeamVisibility.teamPublic
    TeamVisibility.groupOnly -> ApiTeamVisibility.teamGroupOnly
    TeamVisibility.membersOnly -> ApiTeamVisibility.teamMembersOnly
    TeamVisibility.registeredOnly -> ApiTeamVisibility.teamRegisteredOnly
}

fun TeamSaveQuery.Companion.from(query: ApiQueryTeamSave) =
    TeamSaveQuery(
        team = query.data?.toMain()
            ?: TeamModel.NONE
    )

fun ApiQueryTeamFind?.toMain() = if (this == null) TeamFindQuery.EMPTY
else TeamFindQuery(
    offset = offset ?: 0L,
    limit = limit ?: DEFAULT_TEAMS_LIMIT
)