# Internet VPC
resource "aws_vpc" "main-vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"

  tags {
    Name = "main-vpc"
  }
}

# Subnets
resource "aws_subnet" "public-subnet-1" {
  vpc_id                  = "${aws_vpc.main-vpc.id}"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1a"

  tags {
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "public-subnet-2" {
  vpc_id                  = "${aws_vpc.main-vpc.id}"
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1b"

  tags {
    Name = "public-subnet-2"
  }
}

resource "aws_subnet" "public-subnet-3" {
  vpc_id                  = "${aws_vpc.main-vpc.id}"
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1c"

  tags {
    Name = "public-subnet-3"
  }
}

resource "aws_subnet" "private-subnet-1" {
  vpc_id                  = "${aws_vpc.main-vpc.id}"
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1a"

  tags {
    Name = "private-subnet-1"
  }
}

resource "aws_subnet" "private-subnet-2" {
  vpc_id                  = "${aws_vpc.main-vpc.id}"
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1b"

  tags {
    Name = "private-subnet-2"
  }
}

resource "aws_subnet" "private-subnet-3" {
  vpc_id                  = "${aws_vpc.main-vpc.id}"
  cidr_block              = "10.0.6.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1c"

  tags {
    Name = "private-subnet-3"
  }
}

resource "aws_subnet" "database-subnet-1" {
  vpc_id                  = "${aws_vpc.main-vpc.id}"
  cidr_block              = "10.0.7.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1a"

  tags {
    Name = "database-subnet-1"
  }
}

resource "aws_subnet" "database-subnet-2" {
  vpc_id                  = "${aws_vpc.main-vpc.id}"
  cidr_block              = "10.0.8.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1b"

  tags {
    Name = "database-subnet-2"
  }
}

resource "aws_subnet" "database-subnet-3" {
  vpc_id                  = "${aws_vpc.main-vpc.id}"
  cidr_block              = "10.0.9.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1c"

  tags {
    Name = "database-subnet-3"
  }
}

# Internet GW
resource "aws_internet_gateway" "main-igw" {
  vpc_id = "${aws_vpc.main-vpc.id}"

  tags {
    Name = "main-igw"
  }
}

# route tables
resource "aws_route_table" "public-rt" {
  vpc_id = "${aws_vpc.main-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main-igw.id}"
  }

  tags {
    Name = "public-rt"
  }
}

# route associations public
resource "aws_route_table_association" "main-public-1-a" {
  subnet_id      = "${aws_subnet.public-subnet-1.id}"
  route_table_id = "${aws_route_table.public-rt.id}"
}

resource "aws_route_table_association" "main-public-2-a" {
  subnet_id      = "${aws_subnet.public-subnet-2.id}"
  route_table_id = "${aws_route_table.public-rt.id}"
}

resource "aws_route_table_association" "main-public-3-a" {
  subnet_id      = "${aws_subnet.public-subnet-3.id}"
  route_table_id = "${aws_route_table.public-rt.id}"
}

# route associations database
resource "aws_route_table_association" "database-private-1-a" {
  subnet_id      = "${aws_subnet.database-subnet-1.id}"
  route_table_id = "${aws_route_table.private-rt.id}"
}

resource "aws_route_table_association" "database-private-2-a" {
  subnet_id      = "${aws_subnet.database-subnet-2.id}"
  route_table_id = "${aws_route_table.private-rt.id}"
}

resource "aws_route_table_association" "database-private-3-a" {
  subnet_id      = "${aws_subnet.database-subnet-3.id}"
  route_table_id = "${aws_route_table.private-rt.id}"
}

# Network ACLs
resource "aws_network_acl" "public-network-acl" {
  vpc_id = "${aws_vpc.main-vpc.id}"

  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  subnet_ids = ["${aws_subnet.public-subnet-1.id}","${aws_subnet.public-subnet-2.id}","${aws_subnet.public-subnet-3.id}"]

  tags {
    Name = "public-network-acl"
  }
}

resource "aws_network_acl" "private-network-acl" {
  vpc_id = "${aws_vpc.main-vpc.id}"

  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  subnet_ids = ["${aws_subnet.private-subnet-1.id}","${aws_subnet.private-subnet-2.id}","${aws_subnet.private-subnet-3.id}"]

  tags {
    Name = "private-network-acl"
  }
}
