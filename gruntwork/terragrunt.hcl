locals {
    aws_region = "us-east-2"
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.26.0"
    }
  }
}

provider "aws" {
  region = "${local.aws_region}"
  assume_role {
    role_arn    = "arn:aws:iam::509371570690:role/terraform_role"
  }
}
EOF
}

# Configure Terragrunt to automatically store tfstate files in an S3 bucket
remote_state {
  backend = "s3"
  config = {
    encrypt        = true
    bucket         = "awscloudlab.co-terraform-state"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = local.aws_region
    dynamodb_table = "terraform-state-locking"
    role_arn       = "arn:aws:iam::509371570690:role/terraform_role"
}
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}