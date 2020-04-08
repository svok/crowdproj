package com.crowdproj.ktor.storage

import com.amazonaws.services.dynamodbv2.AmazonDynamoDBClientBuilder
import com.amazonaws.services.dynamodbv2.document.DynamoDB
import com.amazonaws.services.dynamodbv2.document.KeyAttribute
import com.amazonaws.services.dynamodbv2.document.Table
import com.amazonaws.services.dynamodbv2.document.spec.ScanSpec
import com.amazonaws.services.dynamodbv2.model.AttributeValue
import com.crowdproj.main.team.ITeamStorage
import com.crowdproj.main.team.models.TeamFindQuery
import com.crowdproj.main.team.models.TeamModel
import io.kotless.AwsResource
import io.kotless.PermissionLevel
import io.kotless.dsl.lang.DynamoDBTable
import io.kotless.dsl.lang.withKotlessLocal
import java.time.Instant
import java.util.*

private const val tableName: String = "crowdproj-teams-table"

@DynamoDBTable(tableName, PermissionLevel.ReadWrite)
object DynamoDbTeamsStorage : ITeamStorage {
    private val client = AmazonDynamoDBClientBuilder.standard().withKotlessLocal(AwsResource.DynamoDB).build()
    private val dynamoDB = DynamoDB(client)

    override suspend fun findTeams(query: TeamFindQuery): Sequence<TeamModel> {
        val table = dynamoDB.getTable(tableName)
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
//            request.withScanIndexForward(query.limit > 0L)
        }

        val scanResult = table.scan(request)

        return scanResult
            ?.asSequence()
            ?.drop(query.offset.toInt())
            ?.map { TeamModel.from(it) }
            ?: emptySequence()
    }

    override suspend fun get(teamId: String): TeamModel? {
        val table = dynamoDB.getTable(tableName)
        val item = table.getItem(KeyAttribute("id", teamId)) ?: return null
        return TeamModel.from(item)
    }

    override suspend fun create(team: TeamModel): String {
        team.id = UUID.randomUUID().toString()
        update(team)
        return team.id
    }

    override suspend fun update(team: TeamModel) {
        val table: Table = dynamoDB.getTable(tableName)
        val item = team.toItem()
        table.putItem(item)
    }

}
