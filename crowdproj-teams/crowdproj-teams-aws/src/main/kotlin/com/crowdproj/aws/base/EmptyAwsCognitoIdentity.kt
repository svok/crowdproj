package com.crowdproj.aws.base

import com.amazonaws.services.lambda.runtime.CognitoIdentity

object EmptyAwsCognitoIdentity : CognitoIdentity {
    override fun getIdentityPoolId(): String = ""
    override fun getIdentityId(): String = ""
}
