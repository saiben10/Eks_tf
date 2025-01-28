provider "aws" {
  region = "east-us-1"
}

resource "aws_vpc" "vpc" {
   cidr_block = var.cidr_range
}

resource "aws_subnet" "sub1" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.sub_range
}

resource "aws_internet_gateway" "ig" {
    vpc_id = aws_vpc.vpc.id

}
resource "aws_route_table" "rt" {
    vpc_id = aws_vpc.vpc.id

    route = {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.ig.id
    }  
}

resource "aws_route_table_association" "rta" {
    route_table_id = aws_route_table.rt.id
    subnet_id = aws_subnet.sub1.id
  
}
