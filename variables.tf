/*
Terraform Variables
*/

variable "domain" { default = "seattlefenix.net" }

variable "region" { default = "us-west-2" }

variable "ns_nodes" { default = 0 }
variable "mx_nodes" { default = 1 }
variable "www_nodes" { default = 0 }

variable "vpc_id" { default = "seattlefenix" }
variable "vpc_cidr" { default = "10.0.0.0/16" }
variable "vpc_subnet_size" { default = "8"}

variable "vpc_pubnets" {
  default = ""
}
variable "vpc_privnets" {
  default = ""
}

variable "ami_centos7" {
  default = {
    us-east-1 = ""
    us-east-2 = ""
    us-west-1 = ""
    us-west-2 = ""
  }
}
