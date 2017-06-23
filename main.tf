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
	vpc_name = "${var.vpc_name}"
	region = "${var.region}"
	domain_name = "${var.domain_name}"
	vpc_cidr = "${var.vpc_cidr}"
	vpc_pubnets = "${var.vpc_pubnets}"
	vpc_privnets = "${var.vpc_privnets}"
	vpc_subnet_size = "${var.vpc_subnet_size}"
}
