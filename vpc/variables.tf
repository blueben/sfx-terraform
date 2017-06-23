/*
Terraform Variables
These variables are required for this module to work correctly
*/

variable "vpc_id" {}
variable "region" {}

// Hosts created in this VPC will be given the hostname region.vpc.domain
variable "domain" {}

// VPC network in CIDR format
variable "cidr" {}

/*
Provide a list of Amazon Availability Zones to use for each type of subnet. A
list is just a comma-delimited string until Terraform 0.7.x comes out.
*/
variable "pubnets" {}
variable "privnets" {}

/*
VPC Subnet size: This number is added to the VPC cidr prefix to get the
subnet prefix.
*/
variable "vpc_subnet_size" {}

data "aws_vpc" "selected" {
  id = "${var.vpc_id}"
  region = "${var.region}"
  domain = "${var.domain}"
  cidr = "${var.cidr}"
  pubnets = "${var.pubnets}"
  privnets = "${var.privnets}"
  netsize = "${var.subnet_size}"
}
