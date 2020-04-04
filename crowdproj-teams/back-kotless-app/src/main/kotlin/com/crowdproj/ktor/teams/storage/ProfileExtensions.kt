package com.crowdproj.ktor.teams.storage

import com.crowdproj.main.profile.ProfileModel
import com.crowdproj.main.profile.ProfileStatusEnum
import com.crowdproj.rest.teams.models.Profile
import com.crowdproj.rest.teams.models.ProfileStatus

fun ProfileModel.toApiProfile(): Profile = Profile(
    id = id,
    alias = alias,
    fName = fName,
    mName = mName,
    lName = lName,
    email = email,
    phone = phone,
    profileStatus = status.toApiProfileStatus()
)

fun Profile?.toMain() =
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
    ProfileStatusEnum.active -> ProfileStatus.profileActive
    ProfileStatusEnum.closed -> ProfileStatus.profileClosed
    ProfileStatusEnum.deleted -> ProfileStatus.profileDeleted
}

fun ProfileStatus?.toMain() = when (this) {
    null -> ProfileStatusEnum.none
    ProfileStatus.profileActive -> ProfileStatusEnum.active
    ProfileStatus.profileClosed -> ProfileStatusEnum.closed
    ProfileStatus.profileDeleted -> ProfileStatusEnum.deleted
}
