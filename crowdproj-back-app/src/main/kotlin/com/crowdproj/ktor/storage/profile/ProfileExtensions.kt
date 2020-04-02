package com.crowdproj.ktor.storage.profile

import com.crowdproj.main.profile.ProfileModel
import com.crowdproj.main.profile.ProfileStatusEnum
import com.crowdproj.rest.models.Profile
import com.crowdproj.rest.models.ProfileStatus

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

private fun ProfileStatusEnum.toApiProfileStatus() = when(this) {
    ProfileStatusEnum.none -> null
    ProfileStatusEnum.active -> ProfileStatus.profileActive
    ProfileStatusEnum.closed -> ProfileStatus.profileClosed
    ProfileStatusEnum.deleted -> ProfileStatus.profileDeleted
}
