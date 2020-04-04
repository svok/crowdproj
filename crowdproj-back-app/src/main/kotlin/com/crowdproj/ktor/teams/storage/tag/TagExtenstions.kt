package com.crowdproj.ktor.teams.storage.tag

import com.crowdproj.main.tag.TagModel
import com.crowdproj.rest.models.Tag

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

fun Array<Tag>?.toMain() = this?.map { it.toMain() }
