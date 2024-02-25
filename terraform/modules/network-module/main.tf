resource "aws_vpc" "vpc" {
  cidr_block           = var.VPC_CIDR
  enable_dns_hostnames = true
  tags = {
    Name = "${var.env_name}-VPC"
  }
}

resource "aws_subnet" "public_subnets" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.public_subnets_cidr[count.index]
  availability_zone = var.subnet_azs[count.index]
  count      = length(var.public_subnets_cidr)
  tags = {
    Name = "${var.public_subnets_names[count.index]}"
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.env_name}-IGW"
  }
}
resource "aws_route_table" "pub_rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.env_name} public Route Table"
  }
}

resource "aws_route_table_association" "pub_rt_assoc" {
  subnet_id      = aws_subnet.public_subnets[count.index].id
  count          = length(var.public_subnets_cidr)
  route_table_id = aws_route_table.pub_rt.id
}

resource "aws_subnet" "private_subnets" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.private_subnets_cidr[count.index]
  availability_zone = var.subnet_azs[count.index]
  count      = length(var.private_subnets_cidr)
  tags = {
    Name = "${var.private_subnets_names[count.index]}"
  }
}

resource "aws_eip" "ngwEIP" {
  domain = "vpc"
  tags = {
    Name = "ngw-EIP"
  }
}
resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.ngwEIP.id
  subnet_id     = aws_subnet.public_subnets[0].id

  tags = {
    Name = "${var.env_name}-NGW"
  }
  depends_on = [aws_eip.ngwEIP]
}
resource "aws_route_table" "prv_rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ngw.id
  }

  tags = {
    Name = "${var.env_name} Private Route Table"
  }
}

resource "aws_route_table_association" "prv_rt_assoc" {
  subnet_id      = aws_subnet.private_subnets[count.index].id
  count          = length(var.private_subnets_cidr)
  route_table_id = aws_route_table.prv_rt.id
}