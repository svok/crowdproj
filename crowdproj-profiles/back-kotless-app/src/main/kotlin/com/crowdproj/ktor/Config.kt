package com.crowdproj.ktor

import io.ktor.auth.OAuthServerSettings
import io.ktor.http.HttpMethod

val ApplicationAuthProviders: Map<String, OAuthServerSettings> = listOf<OAuthServerSettings>(
    OAuthServerSettings.OAuth2ServerSettings(

//static const awsUserPoolId = 'us-east-1_5emWoNX7C';
//static const awsClientId = '7v14t8gpccpaab9qn9rq9i1rit';
//static const identityPoolId = 'us-east-1:c3095362-32fd-4bc2-be8a-0e685848f821';
//static const region = 'us-east-1';
//static const endpoint = 'https://temedis.auth.us-east-1.amazoncognito.com/';

        name = "crowdproj_auth",
        authorizeUrl = "https://temedis.auth.us-east-1.amazoncognito.com/",
        accessTokenUrl = "",
        requestMethod = HttpMethod.Get,
        clientId = "7v14t8gpccpaab9qn9rq9i1rit", //settings.property("auth.oauth.crowdproj_auth.clientId").getString(),
        clientSecret = settings.property("auth.oauth.crowdproj_auth.clientSecret").getString(),
        defaultScopes = listOf("write:teams", "read:teams")
    )
//        OAuthServerSettings.OAuth2ServerSettings(
//                name = "facebook",
//                authorizeUrl = "https://graph.facebook.com/oauth/authorize",
//                accessTokenUrl = "https://graph.facebook.com/oauth/access_token",
//                requestMethod = HttpMethod.Post,
//
//                clientId = "settings.property("auth.oauth.facebook.clientId").getString()",
//                clientSecret = "settings.property("auth.oauth.facebook.clientSecret").getString()",
//                defaultScopes = listOf("public_profile")
//        )
).associateBy { it.name }
