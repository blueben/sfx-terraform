/*
Description: Provision resources that help us support the infrastructure
Maintainer: Benjamin Krueger
Maintainer_email: benjamin@seattlefenix.net

Copyright 2017 Benjamin Krueger
*/

provider "aws" {
  version = "~> 0.1"

  profile = "${var.profile}"
  region  = "${var.infrastructure["region"]}"
  alias   = "init.infrastructure"
}

//
// Infrastructure File Storage
// Here we set up two S3 buckets:
// one to to store infrastructure related files
// one to store access logs for the infrastructure storage bucket

resource "aws_s3_bucket" "site-infrastructure-log" {
  provider           = "aws.init.infrastructure"
  count              = "${var.infrastructure["enable_storage_log"]}"

  bucket             = "${var.site}-infrastructure-log"
  acl                = "log-delivery-write"

  tags {
    "Description"    = "Infrastructure Storage Access Logs"
    "x:managedby"    = "Terraform"
    "x:service_type" = "infrastructure"
  }
}

resource "aws_s3_bucket" "site-infrastructure" {
  provider           = "aws.init.infrastructure"
  count              = "${var.infrastructure["create_storage"]}"

  bucket             = "${var.site}-infrastructure"
  acl                = "private"

  versioning {
    enabled          = true
  }

  logging {
    target_bucket    = "${aws_s3_bucket.site-infrastructure-log.id}"
    target_prefix    = "log/"
  }

  tags {
    "Name"           = "Infrastructure Storage"
    "x:managedby"    = "Terraform"
    "x:service_type" = "infrastructure"
  }
}

// 
// Terraform State Locking
// Here we set up a DynamoDB table to store our state lock.
// https://www.terraform.io/docs/state/locking.html

resource "aws_dynamodb_table" "site-infrastructure-tf-locks" {
  provider           = "aws.init.infrastructure"
  count              = "${var.infrastructure["use_tf_dynamo_lock"]}"

  name               = "${var.site}-infrastructure-tf-locks"
  read_capacity      = 1
  write_capacity     = 1
  hash_key           = "LockID"

  ttl {
    attribute_name   = "TimeToExist"
    enabled          = false
  }

  attribute {
    name             = "LockID"
    type             = "S"
  }

  tags {
    "Description"    = "Terraform State Locks"
    "x:managedby"    = "Terraform"
    "x:service_type" = "infrastructure"
  }
}

//
// Terraform State Files
// Here we create a folder to store our Terraform state files
// https://www.terraform.io/docs/state/remote.html

resource "aws_s3_bucket_object" "terraform-state-files" {
  provider           = "aws.init.infrastructure"
  count              = "${var.infrastructure["use_tf_remote_state"]}"

  bucket             = "${aws_s3_bucket.site-infrastructure.id}"
  acl                = "private"
  key                = "terraform/"

  // We use a different source on Windows vs. UNIX-like systems
  source             = "${var.client_os == "windows" ? "nul": "/dev/null"}"

  tags {
    "Description"    = "Terraform State Files"
    "x:managedby"    = "Terraform"
    "x:service_type" = "infrastructure"
  }
}