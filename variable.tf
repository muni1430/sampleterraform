# AWS provider variables

variable "aws_region" {
  default = "us-west-2"
}

# VPC module variables
variable "environment" {}
variable "vpc_cidr" {}

variable "private_subnet_1" {}
variable "private_subnet_2" {}
variable "private_subnet_3" {}

variable "dmz_subnet_1" {}
variable "dmz_subnet_2" {}
variable "dmz_subnet_3" {}
