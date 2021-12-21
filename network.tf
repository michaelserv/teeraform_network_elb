resource "aws_vpc" "graylogvpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "graylogvpc"
  }
}

resource "aws_subnet" "publicsubnet" {
  vpc_id     = aws_vpc.graylogvpc.id
  cidr_block = var.public_subnet_cidr

  tags = {
    Name = "publicsubnet"
  }
}

resource "aws_subnet" "privatesubnet" {
  vpc_id     = aws_vpc.graylogvpc.id
  cidr_block = var.private_subnet_cidr

  tags = {
    Name = "privatesubnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.graylogvpc.id

  tags = {
    Name = "igw"
  }
}

resource "aws_route_table" "publicrt" {
  vpc_id = aws_vpc.graylogvpc.id

  route {
    cidr_block = var.public_route_cidr_block
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "publicrt"
  }
}

resource "aws_route_table" "privatert" {
  vpc_id = aws_vpc.graylogvpc.id


  tags = {
    Name = "privatert"
  }
}

resource "aws_route_table_association" "publicass" {
  subnet_id      = aws_subnet.publicsubnet.id
  route_table_id = aws_route_table.publicrt.id
}

resource "aws_route_table_association" "privateass" {
  subnet_id      = aws_subnet.privatesubnet.id
  route_table_id = aws_route_table.privatert.id
}

resource "aws_eip" "elasticip" {
  vpc               = true
}

resource "aws_nat_gateway" "example" {
  allocation_id = aws_eip.elasticip.id
  subnet_id     = aws_subnet.publicsubnet.id

  tags = {
    Name = "gw NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}
