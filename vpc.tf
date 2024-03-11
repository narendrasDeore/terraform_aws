# creating VPC with name of demo
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${var.WORKSPACE_NAME}_VPC"
  }
}

# creating public subnet 
resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "${var.WORKSPACE_NAME}_public"
  }
}
# creating public subnet 
resource "aws_subnet" "public_sec" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "ap-south-1b"
  tags = {
    Name = "${var.WORKSPACE_NAME}_public"
  }
}

# creating private subnet 
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "ap-south-1b"
  tags = {
    Name = "${var.WORKSPACE_NAME}_private"
  }
}

# creating private subnet 
resource "aws_subnet" "private_sec" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.7.0/24"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "${var.WORKSPACE_NAME}_private"
  }
}

#route table 
resource "aws_route_table" "example" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "${var.WORKSPACE_NAME}_route"
  }
}


# assocuiate route table with subnet
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.example.id
}

#internet gate way
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.WORKSPACE_NAME}_int_getway"
  }
}


#nat gateway 
resource "aws_nat_gateway" "example" {
  connectivity_type = "private"
  subnet_id         = aws_subnet.private.id
}





