resource "aws_security_group" "public-sg" {
  vpc_id      = "${aws_vpc.main-vpc.id}"
  name        = "public-sg"
  description = "public security group"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "public-sg"
  }
}

resource "aws_security_group" "private-sg" {
  vpc_id      = "${aws_vpc.main-vpc.id}"
  name        = "private-sg"
  description = "app security group"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = ["${aws_security_group.public-sg.id}"]
  }

  tags {
    Name = "private-sg"
  }
}

resource "aws_security_group" "database-sg" {
  vpc_id      = "${aws_vpc.main-vpc.id}"
  name        = "database-sg"
  description = "database security group"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = ["${aws_security_group.public-sg.id}","${aws_security_group.private-sg.id}"]
  }

  ingress {
    from_port   = 1521
    to_port     = 1521
    protocol    = "tcp"
    security_groups = ["${aws_security_group.private-sg.id}"]
  }

  tags {
    Name = "database-sg"
  }
}

