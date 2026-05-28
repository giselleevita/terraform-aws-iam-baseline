# terraform-aws-iam-baseline

Opinionated Terraform baseline for AWS IAM — enforces least-privilege roles, MFA policies, password policy hardening, and audit-ready access logging.

## What it does

- Hardened IAM password policy (length, complexity, rotation)
- MFA enforcement policy for all human users
- Baseline read-only audit role with CloudTrail access
- Deny-all policy for unused regions

## Usage

```hcl
module "iam_baseline" {
  source = "./modules/iam-baseline"
  account_alias = "my-company-prod"
  mfa_enforcement = true
}
```

## Requirements

- Terraform >= 1.3
- AWS provider >= 5.0
- Appropriate IAM permissions to apply policies

## License

MIT
