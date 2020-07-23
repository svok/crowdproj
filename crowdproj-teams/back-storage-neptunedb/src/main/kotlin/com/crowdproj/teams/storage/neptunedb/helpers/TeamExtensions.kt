package com.crowdproj.teams.storage.neptunedb.helpers

import com.crowdproj.teams.back.common.models.TeamVisibility
import com.crowdproj.teams.back.transport.rest.common.models.TeamJoinability
import com.crowdproj.teams.back.transport.rest.common.models.TeamModel
import com.crowdproj.teams.back.transport.rest.common.models.TeamStatusEnum
import org.apache.tinkerpop.gremlin.driver.Tokens
import org.apache.tinkerpop.gremlin.process.traversal.dsl.graph.GraphTraversal
import org.apache.tinkerpop.gremlin.structure.T
import org.apache.tinkerpop.gremlin.structure.Vertex
import java.time.Instant

fun GraphTraversal<Vertex, Vertex>.fromTeam(team: TeamModel): GraphTraversal<Vertex, Vertex> = this
    .property("name", team.name)
    .property("summary", team.summary)
    .property("description", team.description)
    .property("lock", team.lock)
//    .property("photoUrls", team.photoUrls)
//    .property("tags")
//    .property("owner")
    .property("timeCreated", team.timeCreated.toString())
    .property("joinability", team.joinability.toString())
    .property("visibility", team.visibility.toString())
    .property("status", team.status.toString())

fun Map<Any, Any>.team(): TeamModel = TeamModel(
    id = this[T.id] as? String ?: "",
    name = property2string("name") ?: "",
    summary = property2string("summary") ?: "",
    description = property2string("description") ?: "",
    lock = property2string("lock") ?: "",
//    photoUrls =
//    tags =
//    owner =
    timeCreated = property2string("timeCreated")?.let { Instant.parse(it) } ?: Instant.MIN,
    joinability = property2string("joinability")?.let { TeamJoinability.valueOf(it) } ?: TeamJoinability.none,
    visibility = property2string("visibility")?.let { TeamVisibility.valueOf(it) } ?: TeamVisibility.none,
    status = property2string("status")?.let { TeamStatusEnum.valueOf(it) } ?: TeamStatusEnum.none
)

private fun Map<Any,Any>.property2string(prop: Any): String? = (this[prop] as? Collection<*>)?.first() as? String
