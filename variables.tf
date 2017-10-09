/*
Terraform Variables
*/

//
// Client environment
// Some options are different between operating systems
// If you are running Windows, set this to "windows"

variable "client_os"    { default = "unix" }

//
// Site configuration

variable "site"         { default = "sfx" }
variable "site_formal"  { default = "Seattlefenix"}
variable "domain"       { default = "seattlefenix.net" }

//
// AWS configuration

variable "profile"      { default = "seattlefenix" }

//
// Site Infrastructure configuration

variable "infrastructure" {
  default = {
    region              = "us-west-2"
    create_storage      = true
    enable_storage_log  = true
    use_tf_dynamo_lock  = true
    use_tf_remote_state = true
  }
}

//
// VPCs

variable "vpc" { default = ["sfx-services"] }

variable "sfx-services" {
  default = {
    region          = "us-west-2"
    network         = "172.16.192.0/20"
    prefix_extent   = 6
    public_subnets  = 3
    private_subnets = 3
  }
}

//
// Services

variable "service" { default = ["consul", "mx", "www"] }

variable "consul" {
  default = {
    cluster_size  = 0
    az_stripe     = true
    instance_type = "t2.nano"
    ami_name      = ""
    ami_owner     = ""
    use_elb       = false
  }
}

variable "mx" {
  default = {
    cluster_size  = 1
    az_stripe     = true
    instance_type = "t2.micro"
    ami_name      = ""
    ami_owner     = ""
    use_elb       = false
  }
}

variable "www" {
  default = {
    cluster_size  = 0
    az_stripe     = true
    instance_type = "t2.micro"
    ami_name      = ""
    ami_owner     = ""
    use_elb       = false
  }
}

variable "ssh" {
  default = {
    seattlefenix = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCoWL22sriOPL3NPcDgCnJNbUTPXDV5KHTyqfCxlJCUHTvndRQh2dntmbwJyhNtNce3MKkWju8qA2djFfNWgcXQoRqiz78PVA+Qq6oD2iHm5gR2t5KJGOMGCOfSZhfoZcZEP345pO448XX+7FOwYyiNPbFWIUNAQxUFkDWn55fZ2qNzT8AZUDcJD7LxzW0l3LLcBoosGawhiBT9FZpdIYETRG0GXpYg3s+4sX+835Ws8tCvQfZIAjz/ZZ5gz7gik5QcFCy6vG7oW4dwbLJKRfqo66WeQw/9MXbRK1XgSv1yIomUtqUz8mrh85eB93A1thuH6Z74v6vaTkltSaTOg0dh"
  }
}
