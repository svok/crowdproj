package com.crowdproj.ktor.storage.team

import com.amazonaws.services.dynamodbv2.AmazonDynamoDBClientBuilder
import com.amazonaws.services.dynamodbv2.document.DynamoDB
import com.amazonaws.services.dynamodbv2.document.Item
import com.amazonaws.services.dynamodbv2.document.Table
import com.amazonaws.services.dynamodbv2.model.AttributeValue
import com.amazonaws.services.dynamodbv2.model.ScanRequest
import com.crowdproj.main.team.ITeamStorage
import com.crowdproj.main.team.models.TeamModel
import com.crowdproj.main.team.models.TeamFindQuery
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
        val request = ScanRequest()
            .withTableName(tableName)
            .withConsistentRead(true)
            .withExpressionAttributeNames(
                mapOf(
                    "#timeCreated" to "timeCreated"
                )
            )
            .withExpressionAttributeValues(mapOf(
                ":timeCreatedFrom" to AttributeValue().apply { s = query.timeCreatedFrom.toString() },
                ":timeCreatedTill" to AttributeValue().apply { s = query.timeCreatedTill.toString() }
            ))

        if (query.timeCreatedFrom != Instant.MIN) {
            request.withFilterExpression("#timeCreated >= :timeCreatedFrom")
        }
        if (query.timeCreatedTill != Instant.MAX) {
            request.withFilterExpression("#timeCreated <= :timeCreatedTill")
        }

        if (query.offset.isNotBlank()) {
            request.withExclusiveStartKey(
                mapOf(
                    "id" to AttributeValue().withS(query.offset)
                )
            )
        }
        if (query.limit != 0L) {
            request.withLimit(query.limit.toInt())
//            request.withScanIndexForward(query.limit > 0L)
        }

        val items = client.scan(request)

        return items.items.asSequence().map { TeamModel.from(Item.fromMap(it as Map<String,Any>)) }
    }

    override suspend fun get(teamId: String): TeamModel? {
        val table = dynamoDB.getTable(tableName)
        val item = table.getItem("id", teamId) ?: return null

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
