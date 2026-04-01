# terraform-aws-iam-baseline

## 1. Project Overview

This project creates a focused IAM baseline in AWS using Terraform:

- A customer-managed IAM policy that grants read-only S3 access to exactly one bucket
- An IAM role that the policy is attached to

It is intentionally small, opinionated, and production-relevant to demonstrate secure Infrastructure as Code (IaC) practices.

## 2. Why It Matters for Cloud Security

Over-permissive IAM is one of the most common cloud security risks. This project demonstrates least privilege by scoping S3 permissions to a single bucket and specific read actions only.

If credentials are compromised, the blast radius is reduced because the role cannot:

- Read from all buckets
- Write or delete objects
- Perform admin-level IAM actions

## 3. Architecture Summary

The module builds three key components:

- IAM policy document: allows `s3:ListBucket` on `arn:aws:s3:::<bucket_name>` and `s3:GetObject`/`s3:GetObjectVersion` on `arn:aws:s3:::<bucket_name>/*`
- IAM role: assumable by configurable AWS service principals via `sts:AssumeRole`
- IAM policy attachment: links the least-privilege policy to the role

This design separates trust policy (who can assume) from permission policy (what can be done).

## 4. Files in the Repo

- `versions.tf`: Terraform and AWS provider version constraints
- `main.tf`: IAM policy, IAM role, and policy attachment resources
- `variables.tf`: input variable definitions and validation
- `outputs.tf`: exposed values for downstream integration
- `.gitignore`: excludes Terraform state, plans, and local artifacts
- `.github/workflows/terraform-ci.yml`: CI checks for format, validate, lint, and security scanning
- `README.md`: design intent, usage, and security rationale

## 5. Example Usage

Use this project as a root configuration, or call it from another Terraform stack as a local module.

```hcl
module "iam_baseline" {
  source = "./terraform-aws-iam-baseline"

  bucket_name = "my-sensitive-audit-bucket"
  role_name   = "app-s3-readonly-role"

  trusted_service_principals = [
    "ec2.amazonaws.com"
  ]

  tags = {
    Environment = "prod"
    Owner       = "platform-team"
    ManagedBy   = "terraform"
  }
}
```

Run:

```bash
terraform init
terraform plan
terraform apply
```

## 6. Inputs Table

| Name                         | Type           | Required | Default                   | Description                                        |
| ---------------------------- | -------------- | -------- | ------------------------- | -------------------------------------------------- |
| `bucket_name`                | `string`       | Yes      | n/a                       | Name of the S3 bucket to grant read-only access to |
| `role_name`                  | `string`       | Yes      | n/a                       | Name of the IAM role to create                     |
| `trusted_service_principals` | `list(string)` | No       | `[`"ec2.amazonaws.com"`]` | AWS service principals allowed to assume this role |
| `tags`                       | `map(string)`  | No       | `{}`                      | Tags applied to IAM resources                      |

## 7. Outputs Table

| Name         | Type     | Description                                        |
| ------------ | -------- | -------------------------------------------------- |
| `policy_arn` | `string` | ARN of the least-privilege S3 read-only IAM policy |
| `role_name`  | `string` | Name of the IAM role with attached policy          |

## 8. Security Decisions Made

- Scope permissions to one bucket only: avoids accidental account-wide S3 read access
- Read-only action set: excludes write and delete operations
- Customer-managed policy attached to role: enables auditability and controlled reuse
- Explicit role trust policy: limits who can assume the role (configurable, allowlisted service principals)
- Input validation for required names: reduces misconfiguration risk
- Automated CI security and quality checks: catches drift, lint issues, and common misconfigurations before merge

Why this is safer than wildcard permissions:

- Wildcards like `s3:*` or `arn:aws:s3:::*` can expose unrelated data across environments
- Narrow permissions enforce separation of duties and reduce impact during incidents
- Reviewers can reason about intent quickly, which improves security reviews and compliance checks

## 9. Future Improvements

- Parameterize trusted principals (ECS, Lambda, OIDC, cross-account)
- Add optional condition keys (for example, source VPC endpoint or MFA context)
- Support permissions boundaries and IAM path conventions
- Add automated checks with `terraform validate`, `tflint`, and `tfsec` in CI
- Publish as a reusable Terraform module with semantic versioning
