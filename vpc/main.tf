/*
Terraform Module: VPC

Description: Provision a VPC based on input variables
Maintainer: Benjamin Krueger
Maintainer_email: benjamin@seattlefenix.net

Copyright 2017 Benjamin Krueger
License: Apache 2.0
*/

provider "aws" {
  region = "${var.region}"
  profile = "seattlefenix"
  //alias = "${var.alias}"
}

resource "aws_key_pair" "main" {
  key_name    = "seattlefenix"
  public_key  = "${var.ssh["seattlefenix"]}"
}

resource "aws_vpc" "main" {
  cidr_block            = "${cidrsubnet(var.network, 8, var.vpc_count)}"
  enable_dns_support    = true
  enable_dns_hostnames  = true
  enable_classiclink    = false

  tags {
    Name = "${var.alias}"
    ManagedBy = "Terraform"
  }
}

resource "aws_vpc_dhcp_options" "main" {
  domain_name = "${var.alias}.${var.domain}"

  tags {
    Name = "${var.alias}"
    ManagedBy = "Terraform"
  }
}

resource "aws_vpc_dhcp_options_association" "main" {
  vpc_id = "${aws_vpc.main.id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.main.id}"
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "${var.alias} gw"
    ManagedBy = "Terraform"
  }
}

resource "aws_route" "internet" {
  route_table_id         = "${aws_vpc.main.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.gw.id}"
}

/*
  Subnet provisioning
*/

data "aws_availability_zones" "available" {}

resource "aws_subnet" "public" {
  count                   = "${var.public_subnets}"
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "${cidrsubnet(aws_vpc.main.cidr_block, var.prefix_extent, count.index)}"
  availability_zone       = "${element(data.aws_availability_zones.available.names, count.index)}"
  map_public_ip_on_launch = true

  tags {
    Name = "public-subnet-${count.index}"
    Disposition = "public"
    ManagedBy = "Terraform"
  }
}

resource "aws_route_table_association" "public" {
  count           = "${var.public_subnets}"
  subnet_id       = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id  = "${aws_vpc.main.main_route_table_id}"
}

resource "aws_subnet" "private" {
  count                   = "${var.private_subnets}"
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "${cidrsubnet(aws_vpc.main.cidr_block, var.prefix_extent, count.index + 128)}"
  availability_zone       = "${element(data.aws_availability_zones.available.names, count.index)}"
  map_public_ip_on_launch = false

  tags {
    Name = "private-subnet-${count.index}"
    Disposition = "private"
    ManagedBy = "Terraform"
  }
}

resource "aws_route_table_association" "private" {
  count           = "${var.private_subnets}"
  subnet_id       = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id  = "${aws_vpc.main.main_route_table_id}"
}

data "aws_ami" "ubuntu1704" {
  most_recent = true
  // Use only Canonical AMIs please. Otherwise malicious parties could
  // upload their own AMIs that pass this filter.
  owners = ["099720109477"]

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-zesty-17.04-amd64-server-*"]
  }
}

// Output Variables

output "vpc_id"               { value = "${aws_vpc.main.id}" }
output "public_subnet_ids"    { value = "${join(",", aws_subnet.public.*.id)}" }
output "public_subnet_zones"  { value = "${distinct(join(",", aws_subnet.public.*.availability_zone))}" }
output "private_subnet_ids"   { value = "${join(",", aws_subnet.private.*.id)}" }
output "private_subnet_zones" { value = "${distinct(join(",", aws_subnet.private.*.availability_zone))}" }
