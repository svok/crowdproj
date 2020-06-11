package com.crowdproj.teams.storage.dynamodb

import com.crowdproj.teams.back.common.models.TeamVisibility
import com.crowdproj.teams.back.transport.rest.common.models.*
import io.kotest.core.spec.style.StringSpec
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldHave

internal class TeamExtensionsKtTest: StringSpec() {
    init {
        "Team main->db->main" {
            val mainTeam = TeamModel(
                id = "team id",
                name = "team name",
                summary = "team summary",
                description = "team description",
                owner = ProfileModel(
                    id = "profile id",
                    alias = "profile alias",
                    fName = "Firstname",
                    mName = "Middlename",
                    lName = "Lastname",
                    email = "email@domain.com",
                    phone = "+9 999 999 9999",
                    status = ProfileStatusEnum.active
                ),
                photoUrls = setOf(
                    "photo1",
                    "photo2"
                ),
                tags = setOf(
                    TagModel(
                        id = "tag id1",
                        name = "tag name 1",
                        description = "tag description 1"
                    ),
                    TagModel(
                        id = "tag id2",
                        name = "tag name 2",
                        description = "tag description 2"
                    )
                ),
                visibility = TeamVisibility.public,
                joinability = TeamJoinability.byUser,
                status = TeamStatusEnum.active
            )

            val main2Team = TeamModel.from(mainTeam.toItem())

//            main2Team shouldBe mainTeam
            main2Team.id shouldBe mainTeam.id
            main2Team.name shouldBe mainTeam.name
            main2Team.summary shouldBe mainTeam.summary
            main2Team.description shouldBe mainTeam.description
            main2Team.owner.id shouldBe mainTeam.owner.id
            main2Team.photoUrls shouldBe mainTeam.photoUrls
            main2Team.tags.map { it.id } shouldBe mainTeam.tags.map { it.id }
            main2Team.joinability shouldBe mainTeam.joinability
            main2Team.visibility shouldBe mainTeam.visibility
            main2Team.status shouldBe mainTeam.status
        }
    }
}