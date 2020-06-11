package com.crowdproj.teams.storage.dynamodb

import com.amazonaws.services.dynamodbv2.document.Item
import com.crowdproj.teams.back.common.models.*
import com.crowdproj.teams.back.transport.rest.common.models.*


fun TeamModel.toItem() = Item()
    .apply { if (id.isNotBlank()) withPrimaryKey("id", id) }
    .apply { if (name.isNotBlank()) withString("name", name) }
    .apply { if (summary.isNotBlank()) withString("summary", summary) }
    .apply { if (description.isNotBlank()) withString("description", description) }
    .apply { if (owner.id.isNotBlank()) withString("ownerId", owner.id) }
    .apply { if (photoUrls.isNotEmpty()) withStringSet("photoUrls", photoUrls) }
    .apply { if (tags.isNotEmpty()) withStringSet("tagIds", tags.map { it.id }.toSet()) }
    .apply { if (visibility != TeamVisibility.none) withString("visibility", visibility.toString()) }
    .apply { if (joinability != TeamJoinability.none) withString("joinability", joinability.toString()) }
    .apply { if (status != TeamStatusEnum.none) withString("status", status.toString()) }

fun TeamModel.Companion.from(item: Item) = TeamModel(
        id = item.getString("id") ?: "",
        name = item.getString("name") ?: "",
        summary = item.getString("summary") ?: "",
        description = item.getString("description") ?: "",
        owner = item.getString("ownerId")
            ?.let { ProfileModel(id = it) }
            ?: ProfileModel.NONE,
        photoUrls = item.getStringSet("photoUrls") ?: mutableSetOf(),
        tags = item.getStringSet("tagIds")
            ?.asSequence()
            ?.map { TagModel(id = it) }
            ?.toMutableSet()
            ?: mutableSetOf(),
        visibility = TeamVisibility.valueOf(
            item.getString("visibility") ?: "none"
        ),
        joinability = TeamJoinability.valueOf(
            item.getString("joinability") ?: "none"
        ),
        status = TeamStatusEnum.valueOf(
            item.getString("status") ?: "none"
        )
    )
