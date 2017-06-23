/*
Terraform Variables
These variables are required for this module to work correctly
*/

variable "vpc_name" {}
variable "region" {}

// Hosts created in this VPC will be given the hostname region.vpc.domain_name
variable "domain_name" {}

// VPC network in CIDR format
variable "vpc_cidr" {}

/*
Provide a list of Amazon Availability Zones to use for each type of subnet. A
list is just a comma-delimited string until Terraform 0.7.x comes out.
*/
variable "vpc_pubnets" {}
variable "vpc_privnets" {}

/*
VPC Subnet size: This number is added to the VPC cidr prefix to get the
subnet prefix.
*/
variable "vpc_subnet_size" {}
