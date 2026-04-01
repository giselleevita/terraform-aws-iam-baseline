# Security Policy

## Reporting Security Issues

If you discover a security vulnerability in this module, please email security concerns to the maintainer rather than opening a public GitHub issue.

**Do not** publicly disclose security vulnerabilities until they have been addressed.

---

## Security Scope

This module demonstrates **least-privilege IAM patterns** for AWS S3 access. It is designed to show:
- Specific action grants (not wildcards)
- Scoped resource access (one bucket)
- Principle of least privilege in practice

### What This Module Does
- Creates an IAM policy with explicit S3 read-only actions
- Attaches the policy to a configurable IAM role
- Provides clear documentation of security design decisions

### What This Module Does NOT Do
- Provide complete AWS account security hardening
- Include KMS encryption management
- Manage S3 bucket policies or ACLs
- Handle credential rotation or temporary credentials
- Provide IAM user/group management

---

## Assumptions & Limitations

1. **S3 Bucket Pre-exists**: This module assumes the target S3 bucket is already created and managed separately
2. **Trust Relationship**: The module creates role trust for specified principals—validate these are appropriate for your use case
3. **Policy Scope**: Designed for read-only access to a single bucket; modification requires code changes
4. **No Encryption Keys**: Does not manage or grant KMS access; S3 objects must use default encryption or be unencrypted

---

## Dependency Security

This module uses only:
- **Terraform AWS Provider** (v5.0+): Regularly updated by HashiCorp
- **AWS IAM API**: Native AWS service with no external dependencies

Monitor the AWS provider changelog for security updates: https://github.com/hashicorp/terraform-provider-aws/releases

---

## Testing & Validation

All changes to this module are validated with:
- `terraform fmt` — Formatting consistency
- `terraform validate` — Syntax and schema validation
- `tflint` — Best practices linting
- `tfsec` — Security scanning for policy vulnerabilities

Before using in production:
1. Review the generated IAM policy in your AWS console
2. Test with non-production credentials first
3. Validate that the principal trust relationship matches your architecture
4. Use `terraform plan` to audit all changes before applying

---

## Known Limitations

- Single-bucket scope (by design)
- No support for cross-account access in default configuration
- Does not include session duration limits on role assumption
- No MFA requirement enforcement (must be configured separately)

---

## Security Best Practices When Using This Module

1. **Principle of Least Privilege**: Only grant the actions needed for your use case
2. **Resource Scoping**: Limit access to specific S3 buckets, not wildcards
3. **Regular Audits**: Use AWS IAM Access Analyzer to verify permissions are appropriate
4. **Credential Rotation**: Rotate credentials regularly for any principals assuming this role
5. **Monitoring**: Enable CloudTrail and CloudWatch to monitor role usage
6. **Documentation**: Document why each principal needs access for compliance audits

---

## Version Support

- **Terraform**: 1.5.0 or later
- **AWS Provider**: 5.0 or later
- **AWS Account**: Any region that supports IAM (global service)

Older versions may work but are not tested or supported.
