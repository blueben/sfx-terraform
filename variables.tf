/*
Terraform Variables
*/

variable "domain" { default = "seattlefenix.net" }

variable "ns_nodes"   { default = 0 }
variable "mx_nodes"   { default = 1 }
variable "www_nodes"  { default = 0 }

variable "vpc_count"            { default = "1" }
variable "vpc_network"          { default = "10.0.0.0/8" }
variable "vpc_prefix_extent"    { default = "8"}
variable "vpc_public_subnets"   { default = "3" }
variable "vpc_private_subnets"  { default = "3" }

variable "ssh" {
  default = {
    seattlefenix = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCoWL22sriOPL3NPcDgCnJNbUTPXDV5KHTyqfCxlJCUHTvndRQh2dntmbwJyhNtNce3MKkWju8qA2djFfNWgcXQoRqiz78PVA+Qq6oD2iHm5gR2t5KJGOMGCOfSZhfoZcZEP345pO448XX+7FOwYyiNPbFWIUNAQxUFkDWn55fZ2qNzT8AZUDcJD7LxzW0l3LLcBoosGawhiBT9FZpdIYETRG0GXpYg3s+4sX+835Ws8tCvQfZIAjz/ZZ5gz7gik5QcFCy6vG7oW4dwbLJKRfqo66WeQw/9MXbRK1XgSv1yIomUtqUz8mrh85eB93A1thuH6Z74v6vaTkltSaTOg0dh"
  }
}
