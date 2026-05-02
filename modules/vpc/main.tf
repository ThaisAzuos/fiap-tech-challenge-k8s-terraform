resource "aws_vpc" "oficina" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "oficina-vpc"
  }
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.oficina.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "oficina-public-subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.oficina.id
  tags = {
    Name = "oficina-igw"
  }
}
