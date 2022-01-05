resource "aws_instance" "web" {
     ami = "ami-04505e74c0741db8d"
     instance_type = "t2.micro"
     availability_zone = "us-east-1c"
	 key_name = "muneendar54"
	 subnet_id = "subnet-0991fd811575b0586"
	tags = {
	name = "hello world"
	}
 }

