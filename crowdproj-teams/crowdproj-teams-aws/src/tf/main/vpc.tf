resource "aws_vpc" "main_vpc" {
  cidr_block = "10.1.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "myVpc"
  }
}

resource "aws_default_security_group" "main_vpc" {
  vpc_id = aws_vpc.main_vpc.id

  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  timeouts {
    delete = "40m"
  }
  depends_on = [aws_iam_role_policy_attachment.neptune,aws_iam_role_policy_attachment.teams_merged]
}

data "aws_availability_zones" "available" {}

locals {
  neptune_zones = slice(data.aws_availability_zones.available.names, 0, 3)
  public_zones = slice(data.aws_availability_zones.available.names, 3, 5)
  nat_cidrs = ["10.1.10.0/24"]
}

//resource "aws_subnet" "neptune_subnet" {
//  count = length(local.neptune_zones)
//  vpc_id = aws_vpc.main_vpc.id
//  cidr_block = "10.1.${10+count.index}.0/24"
////  availability_zone = data.aws_availability_zones.available.names[count.index]
//  availability_zone = local.neptune_zones[count.index]
//  map_public_ip_on_launch = false
//  timeouts {
//    delete = "40m"
//  }
//  depends_on = [aws_iam_role_policy_attachment.neptune,aws_iam_role_policy_attachment.teams_merged]
//  tags = {
//    Name = "NeptunePublicSubnet"
//  }
//}

resource "aws_iam_policy" "vpc_access" {
  name        = "${var.parametersPrefix}-vpc_access"
  path        = "/"
  description = "IAM policy for accessing VPC subnets"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:DescribeNetworkInterfaces",
        "ec2:CreateNetworkInterface",
        "ec2:DeleteNetworkInterface",
        "ec2:DescribeInstances",
        "ec2:AttachNetworkInterface"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_lb" "lambda-neptune-vpc-lb" {
  name               = "lambda-neptune-vpc-lb"
  internal           = true
  load_balancer_type = "network"
  subnets = aws_subnet.private.*.id

//  subnet_mapping {
//    subnet_id =
//  }
}

resource "aws_api_gateway_vpc_link" "api-lambda-neptune-link" {
  name        = "api-lambda-neptune-link"
  description = "Link for API Gateway connection to the lambda in Neptune VPC"
  target_arns = [aws_lb.lambda-neptune-vpc-lb.arn]
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main_vpc.id
  count                   = length(local.public_zones)
  cidr_block = "10.1.${20+count.index}.0/24"
  //  availability_zone = data.aws_availability_zones.available.names[count.index]
  availability_zone       = element(local.public_zones, count.index)
  map_public_ip_on_launch = true
  timeouts {
    delete = "40m"
  }
  tags = {
    Name = "Neptune Public"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_subnet" "private" {
  vpc_id                  = aws_vpc.main_vpc.id
  count                   = length(local.neptune_zones)
  cidr_block = "10.1.${40+count.index}.0/24"
  availability_zone       = element(local.neptune_zones, count.index)
  map_public_ip_on_launch = false
  tags = {
    Name = "Neptune Private"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main_vpc.id
}

resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private)
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.private.id
}

resource "aws_subnet" "igw" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.1.50.0/24"
  map_public_ip_on_launch = false
  tags = {
    Name = "Subnet for Gateway"
  }
}

resource "aws_subnet" "nat" {
  vpc_id                  = aws_vpc.main_vpc.id
  count                   = length(aws_subnet.public.*.availability_zone)
  cidr_block = "10.1.${30+count.index}.0/24"
  availability_zone       = element(aws_subnet.public.*.availability_zone, count.index)
  map_public_ip_on_launch = false
  tags = {
    Name = "Subnet for NAT"
  }
}

resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.igw.id
}

resource "aws_route_table" "nat" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw.id
  }
}

resource "aws_route_table_association" "nat" {
  count          = length(aws_subnet.nat.*)
  subnet_id      = element(aws_subnet.nat.*.id, count.index)
  route_table_id = aws_route_table.nat.id
}

resource "aws_route_table" "igw" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "igw" {
  subnet_id      = aws_subnet.igw.id
  route_table_id = aws_route_table.igw.id
}

resource "aws_neptune_subnet_group" "private" {
  name       = "neptune_subnets"
  subnet_ids = aws_subnet.private.*.id
}
