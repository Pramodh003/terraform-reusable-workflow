#Elastic IP address 1
resource "aws_eip" "EIP_NAT_IG1" {
    vpc =  true

    tags = {
        Name = "NAT-GW-EP1"
    }
}

resource "aws_eip" "EIP_NAT_IG2" {
    vpc =  true

    tags = {
        Name = "NAT-GW-EP2"
    }
}

#NAT Gateway 1
resource "aws_nat_gateway" "nat_1" {
  allocation_id = aws_eip.EIP_NAT_IG1.id
  subnet_id     = var.pub_sub_1

  tags = {
    Name = "IGW-NAT-1"
  }

  depends_on = [var.igw_id]
}

#NAT Gateway 2
resource "aws_nat_gateway" "nat_2" {
  allocation_id = aws_eip.EIP_NAT_IG1.id
  subnet_id     = var.pub_sub_2

  tags = {
    Name = "IGW-NAT-2"
  }
  depends_on = [var.igw_id]
}

#Private route table 1

resource "aws_route_table" "pri_route_table_1" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_1.id
  }


  tags = {
    Name = "pri-rt-a"
  }
}

#Route table association private 1

resource "aws_route_table_association" "pri_route_table_ass" {
  subnet_id      = var.pri_sub_1
  route_table_id = aws_route_table.pri_route_table_1.id
}

#Private route table 2

resource "aws_route_table" "pri_route_table_2" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_2.id
  }


  tags = {
    Name = "pri-rt-b"
  }
}

#Private route table assocication 2

resource "aws_route_table_association" "a" {
  subnet_id      = var.pri_sub_2
  route_table_id = aws_route_table.pri_route_table_2.id
}