package com.crowdproj.teams.storage.dynamodb

import com.crowdproj.teams.back.transport.rest.common.models.TeamFindQuery
import com.crowdproj.teams.back.transport.rest.common.models.TeamModel
import com.crowdproj.teams.storage.common.ITeamStorage
import org.slf4j.LoggerFactory
import java.util.*
import java.util.concurrent.ConcurrentHashMap

class InMemoryDbTeamsStorage() : ITeamStorage {
    private val logger = LoggerFactory.getLogger(InMemoryDbTeamsStorage::class.java)!!
    private val repository = ConcurrentHashMap<String, TeamModel>()

    override suspend fun findTeams(query: TeamFindQuery): Sequence<TeamModel> {
        return repository
            .asSequence()
            .drop(query.offset.toInt())
            .map { it.value }
    }

    override suspend fun get(teamId: String): TeamModel? = repository.get(teamId)

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
        logger.info("Saving object {}", team)
        repository.set(team.id, team)
        logger.info("Saved object $team")
        return team
    }

    companion object {
        //        var cacheManager = CacheManager.getInstance()
        val DEFAULT by lazy { InMemoryDbTeamsStorage() }
    }
}
