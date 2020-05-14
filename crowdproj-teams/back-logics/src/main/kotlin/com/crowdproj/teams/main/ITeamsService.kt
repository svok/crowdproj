package com.crowdproj.teams.main

interface ITeamsService {
    suspend fun exec(context: TeamContext)
}
