resource "aws_instance" "jumpserver" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"

  # the VPC subnet
  subnet_id = "${aws_subnet.public-subnet-1.id}"

  # the security group
  vpc_security_group_ids = ["${aws_security_group.public-sg.id}"]

  # the public SSH key
  key_name = "${aws_key_pair.mykeypair.key_name}"

  tags {
    Name = "jumpserver"
  }
}

resource "aws_instance" "appserver" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"

  # the VPC subnet
  subnet_id = "${aws_subnet.private-subnet-1.id}"

  # the security group
  vpc_security_group_ids = ["${aws_security_group.private-sg.id}"]

  # the public SSH key
  key_name = "${aws_key_pair.mykeypair.key_name}"

  tags {
    Name = "appserver"
  }
}

resource "aws_instance" "dbserver" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"

  # the VPC subnet
  subnet_id = "${aws_subnet.database-subnet-1.id}"

  # the security group
  vpc_security_group_ids = ["${aws_security_group.database-sg.id}"]

  # the public SSH key
  key_name = "${aws_key_pair.mykeypair.key_name}"

  tags {
    Name = "dbserver"
  }
}

