//https://github.com/crisboarna/terraform-aws-api-gateway-lambda-dynamodb/blob/master/modules/global/iam/main.tf

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

data "aws_iam_policy_document" "crowdproj_teams_table" {
  statement {
    sid    = "AllowRWDynamoDBTable"
    effect = "Allow"

    actions = [
      "dynamodb:DescribeTable",
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:Scan",
      "dynamodb:Query",
      "dynamodb:UpdateItem",
      "dynamodb:DeleteItem",
    ]

    resources = [
      aws_dynamodb_table.crowdproj-teams-table.arn,
      "${aws_dynamodb_table.crowdproj-teams-table.arn}/index/*",
    ]
  }
}
