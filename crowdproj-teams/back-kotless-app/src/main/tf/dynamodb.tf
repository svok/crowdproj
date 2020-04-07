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

}

