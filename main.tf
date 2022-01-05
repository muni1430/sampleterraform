provider "aws" {
  region = "${var.aws_region}"
}
resource "aws_security_group" "beacon" {
  name = "beacon"
  description = "Allow web traffic from the internet"
  vpc_id = "vpc-0b35f76dd9f315be5"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "All traffic"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_instance" "beacon" {
  ami = "ami-04505e74c0741db8d"
  instance_type = "t2.micro"
  subnet_id = "subnet-0991fd811575b0586"
  security_groups = "sg-0025ec649683001e8"
 
  tags {
    Name = "muni"
   
  }
}
