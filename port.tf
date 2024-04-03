terraform {
  required_providers {
    port = {
      source  = "port-labs/port-labs"
      version = "~> 1.0.0"
    }
  }
}

provider "aws" {
  access_key = "AWS_ACCESS_KEY_ID"
  secret_key = "AWS_SECRET_ACCESS_KEY"
  region     = "us-east-2"
}

provider "port" {
  client_id = "PORT_CLIENT_ID"     # or set the environment variable PORT_CLIENT_ID
  secret    = "PORT_CLIENT_SECRET" # or set the environment variable PORT_CLIENT_SECRET
}

resource "aws_s3_bucket" "port-terraform-example-bucket" {
  bucket = "my-port-terraform-example-bucket"
}

resource "aws_s3_bucket_acl" "port-terraform-example-bucket-acl" {
  bucket = aws_s3_bucket.port-terraform-example-bucket.id
  acl    = "private"
}

resource "port_entity" "s3_bucket" {
  depends_on = [
    aws_s3_bucket.port-terraform-example-bucket
  ]

  identifier = aws_s3_bucket.port-terraform-example-bucket.bucket
  title      = aws_s3_bucket.port-terraform-example-bucket.bucket
  blueprint  = "s3Bucket"

  properties = {
    string_props = {
      "isPrivate" = aws_s3_bucket_acl.port-terraform-example-bucket-acl.acl == "private" ? true : false
    }
  }
}
