package com.crowdproj.main.tag

data class TagModel (
    /* Tag's ID that is used in DB and communications */
    var id: kotlin.String = "",
    /* The tag name that is shown to users */
    var name: kotlin.String = "",
    /* The description of the tag */
    var description: kotlin.String = ""
) {
    companion object {
        val NONE = TagModel()
    }
}
