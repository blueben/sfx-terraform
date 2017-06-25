/*
Terraform config for Seattlefenix
*/

// Use the VPC module

module "west01" {
	source 					= "./vpc"
	alias 					= "west"
	region 					= "us-west-2"
	domain 					= "${var.domain}"
	vpc_count				= "${var.vpc_count}"
	network 				= "${var.vpc_network}"
	public_subnets 	= "${var.vpc_public_subnets}"
	private_subnets = "${var.vpc_private_subnets}"
	prefix_extent		= "${var.vpc_prefix_extent}"
	mx_nodes 				= "${var.mx_nodes}"
	ssh			 				= "${var.ssh}"
}
