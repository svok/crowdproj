package com.crowdproj.teams.storage.neptunedb

import com.crowdproj.teams.back.transport.rest.common.models.TeamFindQuery
import com.crowdproj.teams.back.transport.rest.common.models.TeamModel
import com.crowdproj.teams.storage.common.ITeamStorage
import com.crowdproj.teams.storage.neptunedb.helpers.fromTeam
import com.crowdproj.teams.storage.neptunedb.helpers.team
import org.apache.tinkerpop.gremlin.driver.Cluster
import org.apache.tinkerpop.gremlin.driver.remote.DriverRemoteConnection
import org.apache.tinkerpop.gremlin.process.traversal.AnonymousTraversalSource.traversal
import org.apache.tinkerpop.gremlin.process.traversal.P.eq
import org.apache.tinkerpop.gremlin.process.traversal.dsl.graph.`__`.has
import org.apache.tinkerpop.gremlin.process.traversal.step.util.WithOptions
import org.apache.tinkerpop.gremlin.structure.T
import org.slf4j.LoggerFactory
import kotlin.time.ExperimentalTime
import kotlin.time.measureTime
import kotlin.time.measureTimedValue

class NeptuneDbTeamsStorage(
    private val endpoint: String = "",
    private val port: Int = 8182
) : ITeamStorage {

    private val logger = LoggerFactory.getLogger(this.javaClass)
    private val cluster = Cluster.build()
        .addContactPoint(endpoint)
        .port(port)
        .enableSsl(true)
//        .keepAliveInterval(20000)
//        .keyStore()
//        .keyCertChainFile("SFSRootCAG2.pem")
        .create()
    val g = traversal().withRemote(DriverRemoteConnection.using(cluster))

    @OptIn(ExperimentalTime::class)
    override suspend fun get(teamId: String): TeamModel? = try {
        logger.info("GETTING TEAM with teamId: $teamId")
        val graphTeam = measureTimedValue {
            g.V(teamId)
                .filter(has<String>("_type", eq(TeamModel::class.java.simpleName)))
                .valueMap<Any>()
                .with(WithOptions.tokens)
                .next()
                ?.team()
        }
        logger.info("CREATED TEAM (${graphTeam.duration}) for object $graphTeam")
        graphTeam.value
    } catch (e: Throwable) {
        logger.error("GETTING TEAM ERROR:", e)
        throw e
    }

    @OptIn(ExperimentalTime::class)
    override suspend fun findTeams(query: TeamFindQuery): Sequence<TeamModel> = try {
        logger.info("SEARCHING TEAMs with query: $query")
        val teamSequence = measureTimedValue {
            g.V()
                .filter(has<String>("_type", eq(TeamModel::class.java.simpleName)))
                .valueMap<Any>()
                .with(WithOptions.tokens)
                .toStream()
                .iterator()
                .asSequence()
                .map {
                    logger.debug("Got raw TEAM (${it[T.id]} - ${it[T.id]?.javaClass}): \n${it.map { 
                        "'${it.key}'[${it.key.javaClass}]  =   '${it.value}'[${it.value.javaClass}]"
                    }.joinToString("\n")}")
                    it.team()
                }
                .onEach { logger.debug(it.toString()) }
        }
        logger.info("FOUND TEAMs with query (${teamSequence.duration}): $query")
        teamSequence.value
    } catch (e: Throwable) {
        logger.error("SEARCHING TEAM ERROR:", e)
        throw e
    }

    @OptIn(ExperimentalTime::class)
    override suspend fun create(team: TeamModel): TeamModel? = try {
        logger.info("CREATING TEAM for object $team")
        val v = measureTimedValue {
            g.addV()
                .property("_type", team.javaClass.simpleName)
                .fromTeam(team)
                .next()
        }
        logger.info("CREATED TEAM (${v.duration}) for object $team")
        get(v.value.id().toString())
    } catch (e: Throwable) {
        logger.error("CREATING TEAM ERROR:", e)
        throw e
    }

    @OptIn(ExperimentalTime::class)
    override suspend fun update(team: TeamModel): TeamModel? = try {
        logger.info("UPDATING TEAM for object $team")
        val duration = measureTime {
            g.V().has("id", team.id)
                .property("_type", team.javaClass.simpleName)
                .fromTeam(team)
                .next()
        }
        logger.info("UPDATED TEAM ($duration) for object $team")
        get(team.id)
    } catch (e: Throwable) {
        logger.error("UPDATING TEAM ERROR:", e)
        throw e
    }
}
