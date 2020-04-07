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
      "arn:aws:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/crowdproj-teams-table",
      "arn:aws:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/crowdproj-teams-table/index/*",
    ]
  }
}

resource "aws_iam_role_policy" "crowdproj_teams_table" {
  role = "${aws_iam_role.merged_0.name}"
  policy = "${data.aws_iam_policy_document.crowdproj_teams_table.json}"
}

