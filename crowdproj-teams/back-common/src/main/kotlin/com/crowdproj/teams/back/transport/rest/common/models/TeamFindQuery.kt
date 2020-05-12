package com.crowdproj.teams.back.transport.rest.common.models

import com.crowdproj.teams.back.common.models.TeamVisibility
import java.time.Instant

data class TeamFindQuery(
    val tagIds: Set<String> = mutableSetOf(),
    val onDate: Instant = Instant.MAX,
    val timeCreatedFrom: Instant = Instant.MIN,
    val timeCreatedTill: Instant = Instant.MAX,
    val offset: Long = 0L,
    val limit: Long = DEFAULT_TEAMS_LIMIT,
    val statuses: Set<TeamStatusEnum> = mutableSetOf(),
    val visibilities: Set<TeamVisibility> = mutableSetOf(),
    val joinabilities: Set<TeamJoinability> = mutableSetOf()
) {
    companion object {
        const val DEFAULT_TEAMS_LIMIT = 25L
        val EMPTY = TeamFindQuery()
    }
}
