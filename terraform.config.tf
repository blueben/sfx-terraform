terraform {
  backend "s3" {
    profile         = "seattlefenix"
    bucket          = "sfx-infrastructure"
    key             = "terraform/sfx.infrastructure.tf.state"
    region          = "us-west-2"
    dynamodb_table  = "sfx-infrastructure-tf-locks"
  }
}