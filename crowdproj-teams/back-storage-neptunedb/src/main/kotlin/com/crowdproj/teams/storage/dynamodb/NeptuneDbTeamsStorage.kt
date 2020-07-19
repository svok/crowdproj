package com.crowdproj.teams.storage.dynamodb

import com.crowdproj.teams.back.transport.rest.common.models.TeamFindQuery
import com.crowdproj.teams.back.transport.rest.common.models.TeamModel
import com.crowdproj.teams.storage.common.ITeamStorage
import org.slf4j.LoggerFactory
import java.util.*

class NeptuneDbTeamsStorage(
    val neptuneEndpoint: String = ""
) : ITeamStorage {

    private val logger = LoggerFactory.getLogger(this.javaClass)
//    private val client = AmazonDynamoDBClientBuilder
//        .standard()
//        .build()
//    private val dynamoDB = DynamoDB(client)

    override suspend fun findTeams(query: TeamFindQuery): Sequence<TeamModel> {
        return sequence {  }
    }

    override suspend fun get(teamId: String): TeamModel? {
        return null
    }

    override suspend fun create(team: TeamModel): TeamModel? {
        team.id = UUID.randomUUID().toString()
        logger.info("CREATE TEAM for object $team")
        return save(team)
    }

    override suspend fun update(team: TeamModel): TeamModel? {
        logger.info("UPDATE TEAM for object $team")
        return save(team)
    }

    private fun save(team: TeamModel): TeamModel? {
        return null
    }

    companion object {
//        var cacheManager = CacheManager.getInstance()
        val NONE = NeptuneDbTeamsStorage()
    }
}
