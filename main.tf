terraform {
  required_providers {
    port = {
      source  = "port-labs/port-labs"
      version = "~> 1.0.0"
    }
  }
}

provider "aws" {
 access_key = ""
  secret_key = ""
  region     = "us-east-2"
}

#provider "aws" {
#  access_key = "AWS_ACCESS_KEY_ID"
#  secret_key = "AWS_SECRET_ACCESS_KEY"
#  region     = "AWS_REGION"
#}

provider "port" {
  client_id = "JeOjv7ps4CP9y50UaJ2qwb2vsjfmRx6U"     # or set the environment variable PORT_CLIENT_ID
  secret    = "ExcqhgeUXKJWQ73JLXD4dkywxkNLKLDYP582QjbtoFYkgdJLjvFd2ETPFTCzCCZk" # or set the environment variable PORT_CLIENT_SECRET
}

resource "aws_s3_bucket" "port-terraform-mackmart-bucket" {
  bucket = "my-port-terraform-mackmart-bucket"
}

resource "aws_s3_bucket_acl" "port-terraform-mackmart-bucket-acl" {
  bucket = aws_s3_bucket.port-terraform-mackmart-bucket.id
  acl    = "public-read"
}

resource "port_entity" "s3_bucket" {
  depends_on = [
    aws_s3_bucket.port-terraform-mackmart-bucket
  ]

  identifier = aws_s3_bucket.port-terraform-mackmart-bucket.bucket
  title      = aws_s3_bucket.port-terraform-mackmart-bucket.bucket
  blueprint  = "s3Bucket"

  properties = {
    string_props = {
      "isPrivate" = aws_s3_bucket_acl.port-terraform-mackmart-bucket-acl.acl == "private" ? true : false
    }
  }
}
