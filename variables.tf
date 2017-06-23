/*
Terraform Variables
*/

variable "domain_name" { default = "seattlefenix.net" }

variable "region" { default = "us-east-1" }

variable "ns_nodes" { default = 3 }
variable "mx_nodes" { default = 2 }
variable "www_nodes" { default = 1 }

variable "vpc_name" { default = "seattlefenix" }
variable "vpc_cidr" { default = "172.16.0.0/16" }
variable "vpc_subnet_size" { default = "8"}
variable "vpc_pubnets" {
  default = "us-east-1b,us-east-1c,us-east-1d,us-east-1e"
}
variable "vpc_privnets" {
  default = "us-east-1b,us-east-1c,us-east-1d,us-east-1e"
}

variable "ami_centos7" {
  default = {
    us-east-1 = ""
    us-west-1 = ""
    us-west-2 = ""
  }
}
