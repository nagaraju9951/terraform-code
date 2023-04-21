resource "aws_vpc" "test_vpc" {
  cidr_block = var.test_vpc_cidr
  tags = {
    Name = "dev-vpc"
    instance_tenancy = "default"
  }
}

resource "aws_subnet" "publicsubnet-1"{
  vpc_id = aws_vpc.test_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Pb_Name = "public-subnet-1"
  }
}

resource "aws_subnet" "publicsubnet-2"{
  
  vpc_id = aws_vpc.test_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Pb_Name = "public-subnet-2"
     
  }
}

resource "aws_subnet" "publicsubnet-3"{
  vpc_id = aws_vpc.test_vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-1c"
  map_public_ip_on_launch = true

  tags = {
    Pb_Name = "public-subnet-3"
  }
}

resource "aws_internet_gateway" "Igw" {
  vpc_id = aws_vpc.test_vpc.id
  tags = {
    Igw_Name = "test-igw"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.test_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Igw.id
  }
  tags = {
    Name = "dev-route-table"
  }
}

resource "aws_route_table_association" "public-1_association" {
  subnet_id = aws_subnet.publicsubnet-1.id
  route_table_id = aws_route_table.public_route_table.id
}
resource "aws_route_table_association" "public-2_association" {
  subnet_id = aws_subnet.publicsubnet-2.id
  route_table_id = aws_route_table.public_route_table.id
}
resource "aws_route_table_association" "public-3_association" {
  subnet_id = aws_subnet.publicsubnet-3.id
  route_table_id = aws_route_table.public_route_table.id
}
