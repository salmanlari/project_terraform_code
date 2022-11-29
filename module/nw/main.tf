
#vpc
resource "aws_vpc" "aws_vpc" {
  cidr_block       = var.vpccidr
  instance_tenancy = "default"

 tags = {
    Name = "${terraform.workspace}_vpc"

  }
}

#PUB_SUBNET
resource "aws_subnet" "pub_snet" {
  for_each              = var.pub_subnet
  vpc_id                = aws_vpc.aws_vpc.id
  cidr_block            = each.value ["pub_cidr_block"]
  availability_zone     = each.value ["pub_az"] 
  map_public_ip_on_launch = true

  tags = {
    Name = "${terraform.workspace}_vpc"

  }
}

#PVT_SUBNET
resource "aws_subnet" "pvt_snet" {
  vpc_id     = aws_vpc.aws_vpc.id
  cidr_block = var.pvt_cidr_block

   tags = {
    Name = "${terraform.workspace}_vpc"

  }

}

#IGW

resource "aws_internet_gateway" "aws_igw" {
  vpc_id = aws_vpc.aws_vpc.id

   tags = {
    Name = "${terraform.workspace}_vpc"

  }

}

#ROUTE_TABLE

resource "aws_route_table" "aws_rt" {
  vpc_id = aws_vpc.aws_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.aws_igw.id
  
  }

   tags = {
    Name = "${terraform.workspace}_vpc"

  }
}

#ROUTE TABLE ASSOCIATION

resource "aws_route_table_association" "aws_rta" {
  for_each       = aws_subnet.pub_snet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.aws_rt.id


}