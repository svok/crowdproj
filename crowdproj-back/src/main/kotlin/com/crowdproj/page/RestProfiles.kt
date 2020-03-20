package com.crowdproj.page

import com.crowdproj.rest.apis.ProfileApi
import io.ktor.routing.Routing

fun Routing.restProfiles() {
    ProfileApi()
}

// {
//    route("/profile") {
//        post {
//            call.respond(HttpStatusCode.NotImplemented)
//        }
//    }
//
//
//    route("/profile/createWithArray") {
//        post {
//            call.respond(HttpStatusCode.NotImplemented)
//        }
//    }
//
//
//    route("/profile/createWithList") {
//        post {
//            call.respond(HttpStatusCode.NotImplemented)
//        }
//    }
//
//    Paths.
//
//}
