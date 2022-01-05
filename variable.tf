# AWS provider variables
variable "aws_region" {
  default = "us-east-1"
}
# VPC module variables
variable "availability_zone" {
  type    = string
  default = ["us-east-1c"]
}
variable "aws_instance" {
  description = "aws to be used on EC2 instance created"
  type        = string
  default     = ""
}
variable "ami" {
  description = "ID of AMI to use for the instance"
  type        = string
  default     = ""
}
