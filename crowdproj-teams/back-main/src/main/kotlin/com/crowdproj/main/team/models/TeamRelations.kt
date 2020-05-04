package com.crowdproj.main.team.models

enum class TeamRelations {
    own,
    member,
    invitations,
    accessed,
    applied,
    unavailable;

    fun expandRelation() = when (this) {
        own -> setOf(
            own
        )
        member -> setOf(
            own,
            member,
            invitations,
            applied
        )
        accessed -> setOf(
            own,
            member,
            accessed,
            invitations,
            applied
        )
        invitations -> setOf(
            invitations,
            applied
        )
        else -> setOf()
    }
}