data "aws_ami" "demo" {
  most_recent = true

  owners = ["679593333241"]

  filter {
    name   = "image-id"
    values = ["ami-0928d2ae9d7932c7d"]
  }
}


data "aws_security_groups" "vpc_security_group" {

  filter {
    name   = "vpc-id"
    values = [aws_vpc.main.id]
  }

}
data "aws_subnets" "vpc_security_group" {

  filter {
    name   = "vpc-id"
    values = [aws_vpc.main.id]
  }
  filter {
    name   = "tag:Name"
    values = ["${var.WORKSPACE_NAME}_public"]
  }
}

data "aws_availability_zones" "available" {
  state = "available"
  filter {
    name = "zone-id"
    values = [
      "ap-south-1a"
    ]
  }
}

