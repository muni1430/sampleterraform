# VPC

output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}

output "allow_from_bastion_sg" {
  value = "${module.vpc.allow_from_bastion_sg}"
}

output "dmz_1" {
  value = "${module.vpc.subnet_dmz_1}"
}

output "dmz_2" {
  value = "${module.vpc.subnet_dmz_2}"
}

output "dmz_3" {
  value = "${module.vpc.subnet_dmz_3}"
}

output "private_1" {
  value = "${module.vpc.subnet_private_1}"
}

output "private_2" {
  value = "${module.vpc.subnet_private_2}"
}

output "private_3" {
  value = "${module.vpc.subnet_private_3}"
}
