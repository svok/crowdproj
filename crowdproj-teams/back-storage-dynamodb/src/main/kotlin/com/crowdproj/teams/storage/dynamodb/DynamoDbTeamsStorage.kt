package com.crowdproj.teams.storage.dynamodb

import com.amazonaws.AmazonClientException
import com.amazonaws.AmazonServiceException
import com.amazonaws.services.dynamodbv2.AmazonDynamoDBClientBuilder
import com.amazonaws.services.dynamodbv2.document.DynamoDB
import com.amazonaws.services.dynamodbv2.document.KeyAttribute
import com.amazonaws.services.dynamodbv2.document.Table
import com.amazonaws.services.dynamodbv2.document.spec.ScanSpec
import com.amazonaws.services.dynamodbv2.model.AttributeValue
import com.crowdproj.teams.back.transport.rest.common.models.TeamFindQuery
import com.crowdproj.teams.back.transport.rest.common.models.TeamModel
import com.crowdproj.teams.storage.common.ITeamStorage
import com.crowdproj.teams.storage.common.exceptions.DbClientException
import com.crowdproj.teams.storage.common.exceptions.DbServiceException
import com.crowdproj.teams.storage.common.exceptions.DbUnknownException
import org.slf4j.LoggerFactory
import java.time.Instant
import java.util.*

class DynamoDbTeamsStorage(
    val tableName: String = ""
) : ITeamStorage {
    private val logger = LoggerFactory.getLogger(DynamoDbTeamsStorage::class.java)
    private val client = AmazonDynamoDBClientBuilder
        .standard()
        .build()
    private val dynamoDB = DynamoDB(client)

    override suspend fun findTeams(query: TeamFindQuery): Sequence<TeamModel> {
        val table = dynamoDB.getTable(
            tableName
        )
        val request = ScanSpec()
            .withConsistentRead(true)
            .withMaxPageSize(2)

        if (query.timeCreatedFrom != Instant.MIN) {
            request.withFilterExpression("#timeCreated >= :timeCreatedFrom")
        }
        if (query.timeCreatedTill != Instant.MAX) {
            request.withFilterExpression("#timeCreated <= :timeCreatedTill")
        }

        if (false) {
            request
                .withNameMap(
                    mapOf(
                        "#timeCreated" to "timeCreated"
                    )
                )
                .withValueMap(
                    mapOf(
                        ":timeCreatedFrom" to AttributeValue().apply { s = query.timeCreatedFrom.toString() },
                        ":timeCreatedTill" to AttributeValue().apply { s = query.timeCreatedTill.toString() }
                    ))

        }

        if (query.limit != 0L) {
            request.withMaxResultSize((query.limit + query.offset).toInt())
        }

        val scanResult = table.scan(request)

        return scanResult
            ?.asSequence()
            ?.drop(query.offset.toInt())
            ?.map { TeamModel.from(it) }
            ?: emptySequence()
    }

    override suspend fun get(teamId: String): TeamModel? {
        val table = dynamoDB.getTable(
            tableName
        )
        val item = table.getItem(KeyAttribute("id", teamId)) ?: return null
        return TeamModel.from(item)
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
        logger.info("Saving object $team")
        val table: Table = dynamoDB.getTable(tableName)
        val result = try {
            table.putItem(team.toItem())
        } catch (e: AmazonServiceException) {
            logger.error("Error saving object $team: $e")
            throw DbServiceException(team, e)
        } catch (e: AmazonClientException) {
            logger.error("Error saving object $team: $e")
            throw DbClientException(team, e)
        } catch (e: Throwable) {
            logger.error("Error saving object $team: $e")
            throw DbUnknownException(team, e)
        }
        logger.info("Saved object $team")
        return team
    }

    companion object {
//        var cacheManager = CacheManager.getInstance()
    }
}
