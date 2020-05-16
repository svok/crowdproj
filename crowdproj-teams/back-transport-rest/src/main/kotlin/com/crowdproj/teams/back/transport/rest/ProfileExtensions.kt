package com.crowdproj.teams.back.transport.rest

import com.crowdproj.rest.teams.models.RestProfile
import com.crowdproj.rest.teams.models.RestProfileStatus
import com.crowdproj.teams.back.transport.rest.common.models.ProfileModel
import com.crowdproj.teams.back.transport.rest.common.models.ProfileStatusEnum

fun ProfileModel.toApi(): RestProfile = RestProfile(
    id = id.takeIf { it.isNotBlank() },
    alias = alias.takeIf { it.isNotBlank() },
    fName = fName.takeIf { it.isNotBlank() },
    mName = mName.takeIf { it.isNotBlank() },
    lName = lName.takeIf { it.isNotBlank() },
    email = email.takeIf { it.isNotBlank() },
    phone = phone.takeIf { it.isNotBlank() },
    profileStatus = status.toApiProfileStatus()
)

fun RestProfile?.toMain() =
    if (this == null) ProfileModel.NONE
    else ProfileModel(
        id = id ?: "",
        alias = alias ?: "",
        fName = fName ?: "",
        lName = lName ?: "",
        mName = mName ?: "",
        email = email ?: "",
        phone = phone ?: "",
        status = profileStatus.toMain()
    )

fun ProfileStatusEnum.toApiProfileStatus() = when (this) {
    ProfileStatusEnum.none -> null
    ProfileStatusEnum.active -> RestProfileStatus.profileActive
    ProfileStatusEnum.closed -> RestProfileStatus.profileClosed
    ProfileStatusEnum.deleted -> RestProfileStatus.profileDeleted
}

fun RestProfileStatus?.toMain() = when (this) {
    null -> ProfileStatusEnum.none
    RestProfileStatus.profileActive -> ProfileStatusEnum.active
    RestProfileStatus.profileClosed -> ProfileStatusEnum.closed
    RestProfileStatus.profileDeleted -> ProfileStatusEnum.deleted
}
