package com.crowdproj.ktor.teams.storage.profile

import com.crowdproj.rest.apis.ProfileApi
import io.ktor.routing.Routing

fun Routing.restProfiles() {
    ProfileApi()
}
