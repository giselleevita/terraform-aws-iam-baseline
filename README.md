# terraform-aws-iam-baseline

![Terraform](https://img.shields.io/badge/terraform-%3E%3D1.3-purple)
![AWS](https://img.shields.io/badge/AWS-IAM%20%7C%20CloudTrail-orange)
![License](https://img.shields.io/badge/license-MIT-green)

> Opinionated Terraform baseline for AWS IAM — enforces least-privilege roles, MFA policies, password hardening, unused region lockdown, and audit-ready access logging.

Drop this module into any AWS account to establish a security-hardened IAM baseline aligned with CIS AWS Foundations Benchmark and NIST SP 800-53.

---

## What It Enforces

| Control | Implementation |
|---|---|
| Password complexity & rotation | IAM account password policy (length ≥14, symbols, expiry 90d) |
| MFA for all human users | SCP-style deny policy — blocks console access without MFA |
| Least-privilege audit role | Read-only role scoped to CloudTrail, Config, and IAM read |
| Unused region lockdown | Deny-all SCP for non-approved AWS regions |
| Audit logging | CloudTrail enabled with S3 delivery and integrity validation |

---

## Compliance Mapping

| Framework | Controls Covered |
|---|---|
| CIS AWS Foundations v2 | 1.5, 1.8, 1.10, 1.14, 1.15, 2.1 |
| NIST SP 800-53 | AC-2, AC-3, AC-6, AU-2, AU-9, IA-5 |
| ISO 27001:2022 | A.5.15, A.5.16, A.5.18, A.8.2 |

---

## Usage

```hcl
module "iam_baseline" {
  source           = "./modules/iam-baseline"
  account_alias    = "my-company-prod"
  mfa_enforcement  = true
  approved_regions = ["eu-west-1", "eu-central-1"]
}
```

---

## Requirements

- Terraform >= 1.3
- AWS provider >= 5.0
- IAM permissions: `iam:*`, `organizations:AttachPolicy` (for SCPs)

---

## Related

- [terraform-aws-secure-vpc](https://github.com/giselleevita/terraform-aws-secure-vpc) — hardened VPC baseline
- [secure-docs-aws](https://github.com/giselleevita/secure-docs-aws) — encrypted document storage with KMS + IAM

---

## License

MIT
