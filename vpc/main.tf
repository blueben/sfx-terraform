/*
Terraform Module: VPC

Description: Provision a VPC based on input variables
Maintainer: Benjamin Krueger
Maintainer_email: benjamin@seattlefenix.net

Copyright 2017 Benjamin Krueger
License: Apache 2.0
*/

resource "aws_vpc" "main" {
  cidr_block = "${var.vpc_cidr}"
  instance_tenancy = "default"
  tags {
    Name = "${var.vpc_name}"
  }
  enable_dns_support    = true
  enable_dns_hostnames  = true
    enable_classiclink    = false
}

resource "aws_vpc_dhcp_options" "dhcp" {
  domain_name = "${var.region}.vpc.${var.domain_name}"
}

resource "aws_vpc_dhcp_options_association" "dhcp" {
  vpc_id = "${aws_vpc.main.id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.dhcp.id}"
}

resource "aws_internet_gateway" "gw" {
    vpc_id = "${aws_vpc.main.id}"

    tags {
        Name = "${var.vpc_name}"
    }
}

/*
  Subnet provisioning

This module expects vpc_privnets and vpc_pubnets to be a comma-delimited string of availability zones.

TODO: Re-add functionality to stripe subnets across all of the defined availability zones.
*/

resource "aws_subnet" "private" {
  count             = "${length(split(",", var.vpc_privnets))}"
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${cidrsubnet(var.vpc_cidr, var.vpc_subnet_size, count.index)}"
  availability_zone = "${element(split(",", var.vpc_privnets), count.index % length(split(",", var.vpc_privnets)))}"
  tags {
    Name = "Private Subnet ${count.index}"
  }
  map_public_ip_on_launch = false
}

resource "aws_subnet" "public" {
  count             = "${length(split(",", var.vpc_pubnets))}"
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${cidrsubnet(var.vpc_cidr, var.vpc_subnet_size, count.index + length(split(",", var.vpc_privnets)))}"
  availability_zone = "${element(split(",", var.vpc_pubnets), count.index % length(split(",", var.vpc_pubnets)))}"
  tags {
    Name = "Public Subnet ${count.index}"
  }
  map_public_ip_on_launch = true
}

// Output Variables

output "vpc_id"   { value = "${aws_vpc.main.id}" }
output "pubnet_ids" { value = "${join(",", aws_subnet.public.*.id)}" }
output "pubnet_azs" { value = "${join(",", aws_subnet.public.*.availability_zone)}" }
output "privnet_ids" { value = "${join(",", aws_subnet.private.*.id)}" }
output "privnet_azs" { value = "${join(",", aws_subnet.private.*.availability_zone)}" }
