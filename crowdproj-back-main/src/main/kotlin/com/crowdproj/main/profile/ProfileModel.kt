package com.crowdproj.main.profile

data class ProfileModel (
    var id: kotlin.String = "",
    var alias: kotlin.String = "",
    var fName: kotlin.String = "",
    var lName: kotlin.String = "",
    var mName: kotlin.String = "",
    var email: kotlin.String = "",
    var phone: kotlin.String = "",
    var status: ProfileStatusEnum = ProfileStatusEnum.none
) {
    companion object {
        val NONE = ProfileModel()
    }
}
