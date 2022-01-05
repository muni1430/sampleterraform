provider "aws" {
  region = "${var.aws_region}"
}
module "vpc" {
  source = "../modules/vpc"
  aws_region = "${var.aws_region}"
  environment = "${var.environment}"
}
