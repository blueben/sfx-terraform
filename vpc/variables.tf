/*
Terraform Variables
These variables are required for this module to work correctly
*/

variable "alias" {
}
variable "region" {
}
variable "domain" {
  description = "Domain used for node FQDNs. eg: host.vpc_domain"
}
variable "vpc_count" {
  description = "The number of planned VPC networks. Maximum of 254"
}
variable "network" {
  description = "VPC network in CIDR format"
}
variable "public_subnets" {
  description = "How many public subnets to create. Maximum of 127"
}
variable "private_subnets" {
  description = "How many private subnets to create. Maximum of 127"
}
variable "prefix_extent" {
  description = "This number is added to the VPC cidr prefix to get the subnet prefix"
}
variable "mx_nodes" {
  description = "How many mail exchange nodes to create"
}
variable "ssh" {
  type = "map"
}
