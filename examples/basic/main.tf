# Minimal example: a read-only IAM role scoped to a single S3 bucket.
# Run: terraform init && terraform plan

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

provider "aws" {
  region = "eu-north-1"
}

module "s3_read_role" {
  source = "../../"

  bucket_name = "my-audit-evidence-bucket"
  role_name   = "audit-evidence-reader"

  trusted_service_principals = ["ec2.amazonaws.com"]

  tags = {
    Environment = "dev"
    Owner       = "security"
  }
}

output "role_name" {
  value = module.s3_read_role.role_name
}

output "policy_arn" {
  value = module.s3_read_role.policy_arn
}
