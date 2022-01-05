provider "aws" {
  region = "${var.aws_region}"
}

# Resources

resource "aws_route53_zone" "public" {
  name = "domain.com"
}

resource "atlas_artifact" "bastion" {
  name = "example-hashicorp-org/bastion"
  type = "aws.ami"
}

resource "atlas_artifact" "beacon" {
  name = "example-hashicorp-org/beacon"
  type = "aws.ami"
}

# Modules

module "vpc" {
  source = "../modules/vpc"
  aws_region = "${var.aws_region}"
  environment = "${var.environment}"
  public_dns_zone = "${aws_route53_zone.public.zone_id}"

  vpc_cidr = "${var.vpc_cidr}"

  private_subnet_1 = "${var.private_subnet_1}"
  private_subnet_2 = "${var.private_subnet_2}"
  private_subnet_3 = "${var.private_subnet_3}"

  dmz_subnet_1 = "${var.dmz_subnet_1}"
  dmz_subnet_2 = "${var.dmz_subnet_2}"
  dmz_subnet_3 = "${var.dmz_subnet_3}"

  bastion_ami = "${atlas_artifact.bastion.metadata_full.region-us-west-2}"
}

resource "aws_security_group" "beacon" {
  name = "beacon"
  description = "Allow web traffic from the internet"
  vpc_id = "${module.vpc.vpc_id}"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_eip" "beacon" {
  instance = "${aws_instance.beacon.id}"
  vpc = true
}

resource "aws_instance" "beacon" {
  ami = "${atlas_artifact.beacon.metadata_full.region-us-west-2}"
  instance_type = "t2.micro"
  subnet_id = "${module.vpc.subnet_dmz_1}"
  security_groups = ["${aws_security_group.beacon.id}","${module.vpc.allow_from_bastion_sg}"]
  iam_instance_profile = "beacon-role"

  tags {
    Name = "beacon-${var.environment}"
    Environment = "${var.environment}"
  }
}

resource "aws_route53_record" "beacon" {
  zone_id = "${aws_route53_zone.public.zone_id}"
  name = "beacon.domain.com"
  type = "A"
  ttl = "300"
  records = ["${aws_instance.beacon.public_ip}"]
}

resource "aws_route53_record" "beacon-host" {
  zone_id = "${aws_route53_zone.public.zone_id}"
  name = "beacon.us-west-2.domain.com"
  type = "A"
  ttl = "300"
  records = ["${aws_instance.beacon.private_ip}"]
}
