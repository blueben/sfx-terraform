/*
Terraform config for Seattlefenix
*/

provider "aws" {
	region = "${var.region}"
	profile = "seattlefenix"
}

// Use the VPC module

module "vpc" {
	source = "./vpc"
	vpc_id= "${var.vpc_id}"
	region = "${var.region}"
	domain = "${var.domain}"
	cidr = "${var.vpc_cidr}"
	pubnets = "${var.vpc_pubnets}"
	privnets = "${var.vpc_privnets}"
	subnet_size = "${var.vpc_subnet_size}"
}
