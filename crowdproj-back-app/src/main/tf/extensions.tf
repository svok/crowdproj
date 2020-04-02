resource "aws_dynamodb_table" "crowdproj-teams-table" {
  name = "crowdproj-teams-table"
  billing_mode = "PROVISIONED"
  read_capacity = 20
  write_capacity = 20
  hash_key = "id"

  attribute {
    name = "id"
    type = "S"
  }

//  attribute {
//    name = "name"
//    type = "S"
//  }
//
//  attribute {
//    name = "summary"
//    type = "S"
//  }
//
//  attribute {
//    name = "description"
//    type = "S"
//  }
//
//  attribute {
//    name = "ownerId"
//    type = "S"
//  }
//
//  attribute {
//    name = "photoUrls"
//    type = "S"
//  }
//
//  attribute {
//    name = "tags"
//    type = "S"
//  }
//
//  attribute {
//    name = "visibility"
//    type = "S"
//  }
//
//  attribute {
//    name = "joinability"
//    type = "S"
//  }
//
//  attribute {
//    name = "status"
//    type = "S"
//  }
//
//  attribute {
//    name = "timeCreated"
//    type = "S"
//  }

}
