package com.crowdproj.teams.back.transport.rest

import com.crowdproj.rest.teams.models.RestTag
import com.crowdproj.teams.back.transport.rest.common.models.TagModel

fun Set<TagModel>.toApiTags() = this.map { it.toApiTag() }

fun TagModel.toApiTag() = RestTag(
    id = id,
    name = name,
    description = description
)

fun RestTag?.toMain() =
    if (this == null) TagModel.NONE
    else TagModel(
        id = id ?: "",
        name = name ?: "",
        description = description ?: ""
    )
