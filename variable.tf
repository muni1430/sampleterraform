# AWS provider variables

variable "aws_region" {
  default = "us-east-1"
}

# VPC module variables
variable "image_id" {
  type = string
}

variable "availability_zone_names" {
  type    = string
  default = ["us-east-1"]
}
