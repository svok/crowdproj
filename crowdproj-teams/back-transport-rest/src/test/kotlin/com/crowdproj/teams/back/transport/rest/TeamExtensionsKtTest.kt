package com.crowdproj.teams.back.transport.rest

import com.crowdproj.rest.teams.models.*
import io.kotest.core.spec.style.StringSpec
import io.kotest.matchers.shouldBe

internal class TeamExtensionsKtTest : StringSpec() {
    init {
        "Team empty: Api->Main->Api" {
            val apiTeam = RestTeam(
                name = "team name",
                summary = "team summary"
            )

            val api2Team = apiTeam.toMain().toApi()
            api2Team.tags shouldBe apiTeam.tags
            api2Team.owner shouldBe apiTeam.owner
            api2Team.id shouldBe apiTeam.id
            api2Team.name shouldBe apiTeam.name
            api2Team.summary shouldBe apiTeam.summary
            api2Team.description shouldBe apiTeam.description
            api2Team.joinability shouldBe apiTeam.joinability
            api2Team.photoUrls shouldBe apiTeam.photoUrls
            api2Team.status shouldBe apiTeam.status
            api2Team.visibility shouldBe apiTeam.visibility
            api2Team shouldBe apiTeam
        }
        "Team full: Api->Main->Api" {
            val apiTeam = RestTeam(
                id = "team id",
                name = "team name",
                summary = "team summary",
                description = "team description",
                owner = RestProfile(
                    id = "profile id",
                    alias = "profile alias",
                    fName = "Firstname",
                    mName = "Middlename",
                    lName = "Lastname",
                    email = "email@domain.com",
                    phone = "+9 999 999 9999",
                    profileStatus = RestProfileStatus.profileActive
                ),
                photoUrls = arrayOf(
                    "photo1",
                    "photo2"
                ),
                tags = arrayOf(
                    RestTag(
                        id = "tag id1",
                        name = "tag name 1",
                        description = "tag description 1"
                    ),
                    RestTag(
                        id = "tag id2",
                        name = "tag name 2",
                        description = "tag description 2"
                    )
                ),
                visibility = RestTeamVisibility.teamPublic,
                joinability = RestTeamJoinability.byUser,
                status = RestTeamStatus.active,
                cans = setOf(
                    RestTeamOperations.apply,
                    RestTeamOperations.invite
                )
            )

            val api2Team = apiTeam.toMain().toApi()
            api2Team.tags shouldBe apiTeam.tags
            api2Team.owner shouldBe apiTeam.owner
            api2Team.id shouldBe apiTeam.id
            api2Team.name shouldBe apiTeam.name
            api2Team.summary shouldBe apiTeam.summary
            api2Team.description shouldBe apiTeam.description
            api2Team.joinability shouldBe apiTeam.joinability
            api2Team.photoUrls shouldBe apiTeam.photoUrls
            api2Team.status shouldBe apiTeam.status
            api2Team.visibility shouldBe apiTeam.visibility
            api2Team.cans shouldBe apiTeam.cans
//            api2Team shouldBe apiTeam
        }
    }
}