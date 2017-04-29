provider "aws" {
  access_key = "AKIAIDOY5EDRPR3RSJGQ"
  secret_key = "iEGnhAfhHomBufk6GIRr3ZWeOut3GQClvf7xM6pW"
  region     = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-a025aeb6"
  instance_type = "t2.micro"
}
