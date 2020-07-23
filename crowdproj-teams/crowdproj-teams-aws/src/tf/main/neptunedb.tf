resource "aws_neptune_cluster" "default" {
  cluster_identifier                  = "crowdproj-prod"
  engine                              = "neptune"
  backup_retention_period             = 1
  preferred_backup_window             = "07:00-09:00"
  skip_final_snapshot                 = true
//  iam_database_authentication_enabled = true
  iam_database_authentication_enabled = false
  apply_immediately                   = true
  neptune_subnet_group_name           = aws_neptune_subnet_group.private.name
  vpc_security_group_ids              = [aws_default_security_group.main_vpc.id]
  iam_roles                           = [aws_iam_role.role.arn]
  availability_zones = aws_subnet.private.*.availability_zone
//  availability_zones = local.neptune_zones
}

resource "aws_neptune_cluster_instance" "prod" {
  count              = 2
  cluster_identifier = aws_neptune_cluster.default.id
  engine             = "neptune"
  instance_class     = "db.r4.large"
  apply_immediately  = true

  # publicly_accessible = true
}

resource "aws_iam_role" "role" {
  name = "neptune_role"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": ["ec2.amazonaws.com", "rds.amazonaws.com"]
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "neptune-full-access" {
  policy_arn = "arn:aws:iam::aws:policy/NeptuneFullAccess"
  role       = aws_iam_role.role.name
}

output "neptune_cluster_endpoint" {
  value = aws_neptune_cluster.default.endpoint
}
output "neptune_cluster_port" {
  value = aws_neptune_cluster.default.port
}
output "neptune_cluster_vpcs" {
  value = aws_neptune_cluster.default.vpc_security_group_ids
}

# Parameter store in SSM
resource "aws_ssm_parameter" "parameter-neptune-endpoint" {
  name  = var.parameterNeptuneEndpoint
  type  = "String"
  value = aws_neptune_cluster.default.endpoint
}
resource "aws_ssm_parameter" "parameter-neptune-port" {
  name  = var.parameterNeptunePort
  type  = "String"
  value = aws_neptune_cluster.default.port
}

output "neptune_cluster_arn" {
  value = aws_neptune_cluster.default.arn
}

//output "neptune_client_ip" {
//  value = "${module.client.public_ip}"
//}

variable "parameterNeptuneEndpoint" {
  default = ""
}
variable "parameterNeptunePort" {
  default = "8182"
}
