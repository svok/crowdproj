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

//data "aws_caller_identity" "current" {}
//data "aws_region" "current" {}
//data "aws_iam_policy_document" "crowdproj-teams-table" {
//  statement {
//    sid    = "AllowRWDynamoDBTable"
//    effect = "Allow"
//
//    actions = [
//      "dynamodb:DescribeTable",
//      "dynamodb:GetItem",
//      "dynamodb:PutItem",
//      "dynamodb:Scan",
//      "dynamodb:Query",
//      "dynamodb:UpdateItem",
//      "dynamodb:DeleteItem",
//    ]
//
//    resources = [
//      "arn:aws:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/crowdproj-teams-table",
//      "arn:aws:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/crowdproj-teams-table/index/*",
//    ]
//  }
//}
