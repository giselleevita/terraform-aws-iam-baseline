mock_provider "aws" {
  mock_data "aws_iam_policy_document" {
    defaults = {
      json = "{}"
    }
  }
}

variables {
  bucket_name = "audit-evidence-prod"
  role_name   = "audit-evidence-reader"
}

run "least_privilege_policy" {
  command = plan

  assert {
    condition     = toset(data.aws_iam_policy_document.s3_read_only.statement[1].resources) == toset(["arn:aws:s3:::audit-evidence-prod/*"])
    error_message = "Object reads must be limited to the configured bucket."
  }

  assert {
    condition     = toset(data.aws_iam_policy_document.s3_read_only.statement[1].actions) == toset(["s3:GetObject", "s3:GetObjectVersion"])
    error_message = "The policy must not grant wildcard S3 actions."
  }

  assert {
    condition     = toset(flatten([for principal in data.aws_iam_policy_document.assume_role.statement[0].principals : principal.identifiers])) == toset(["ec2.amazonaws.com"])
    error_message = "Only the configured service principal may assume the role."
  }
}

run "rejects_wildcard_principal" {
  command = plan

  variables {
    trusted_service_principals = ["*"]
  }

  expect_failures = [var.trusted_service_principals]
}
