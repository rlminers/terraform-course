# nat gw
resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = "${aws_eip.nat.id}"
  subnet_id     = "${aws_subnet.public-subnet-1.id}"
  depends_on    = ["aws_internet_gateway.main-igw"]
}

# VPC setup for NAT
resource "aws_route_table" "private-rt" {
  vpc_id = "${aws_vpc.main-vpc.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat-gw.id}"
  }

  tags {
    Name = "private-rt"
  }
}

# route associations private
resource "aws_route_table_association" "main-private-1-a" {
  subnet_id      = "${aws_subnet.private-subnet-1.id}"
  route_table_id = "${aws_route_table.private-rt.id}"
}

resource "aws_route_table_association" "main-private-2-a" {
  subnet_id      = "${aws_subnet.private-subnet-2.id}"
  route_table_id = "${aws_route_table.private-rt.id}"
}

resource "aws_route_table_association" "main-private-3-a" {
  subnet_id      = "${aws_subnet.private-subnet-3.id}"
  route_table_id = "${aws_route_table.private-rt.id}"
}
