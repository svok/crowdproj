package com.crowdproj.teams.back.transport.rest

import com.crowdproj.rest.teams.models.Tag
import com.crowdproj.teams.back.transport.rest.common.models.TagModel

fun Set<TagModel>.toApiTags() = this.map { it.toApiTag() }

fun TagModel.toApiTag() = Tag(
    id = id,
    name = name,
    description = description
)

fun Tag?.toMain() =
    if (this == null) TagModel.NONE
    else TagModel(
        id = id ?: "",
        name = name ?: "",
        description = description ?: ""
    )
