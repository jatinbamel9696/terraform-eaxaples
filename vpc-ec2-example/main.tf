locals {
  env    = "test"
  owner  = "jatin"
}

locals {
  # Common tags to be assigned to all resources
  common_tags = {
    Service = local.env
    Owner   = local.owner
  }
}

# VPC
resource "aws_vpc" "terra_vpc" {
  cidr_block       = var.vpc_cidr
  tags = {
    Name = "Terraform-VPC"
  }
}
  

# Internet Gateway
resource "aws_internet_gateway" "terra_igw" {
  vpc_id = aws_vpc.terra_vpc.id
  tags = {
    Name = "main-ig"
  }
}

# Subnets : public
resource "aws_subnet" "public" {
  count = length(var.subnets_cidr)
  vpc_id = aws_vpc.terra_vpc.id
  cidr_block = element(var.subnets_cidr,count.index)
  availability_zone = element(var.azs,count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "Public-subnet-${element(var.azs, count.index)}"
    Environment = "Test"
  }
}

# Route table: attach Internet Gateway 
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.terra_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terra_igw.id
  }
  tags = {
    Name = "publicRouteTable"
  }
}

# Route table association with public subnets
resource "aws_route_table_association" "a" {
  count = length(var.subnets_cidr)
  subnet_id      = element(aws_subnet.public.*.id,count.index)
  route_table_id = aws_route_table.public_rt.id
}


# Security Group

resource "aws_security_group" "public-sg" {
  name = "public-sg-${local.env}"
  description = "Allow all access"
  vpc_id = aws_vpc.terra_vpc.id
  tags = merge(local.common_tags,
    {
      Name = "test-public-sg"
    },)
}

resource "aws_security_group_rule" "public_out" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
 
  security_group_id = aws_security_group.public-sg.id
}

resource "aws_security_group_rule" "public_in_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.public-sg.id
}

resource "aws_instance" "test-instance" {
  ami = "ami-05fa00d4c63e32376"
  instance_type = "t2.micro"
  key_name      = "rinkuaws"
  subnet_id = aws_subnet.public[0].id
  vpc_security_group_ids = [aws_security_group.public-sg.id]
  tags = {
    "Name" : "test-instance"
  }
  
}


