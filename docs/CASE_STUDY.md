# Case Study: Terraform AWS IAM S3 Read Role

## Problem

Small AWS workloads often need one service to read evidence, logs, exports, or reports from a specific S3 bucket. A common mistake is to attach broad managed policies such as `AmazonS3ReadOnlyAccess`, which grants read visibility across too much of the account.

This module demonstrates the narrower pattern: create one role, one trust boundary, and one bucket-scoped read-only policy.

## Solution

The Terraform module creates:

- an IAM policy that allows `s3:ListBucket` only on one bucket
- object read permissions only under that same bucket
- an IAM role that can be assumed only by configured AWS service principals
- a role-policy attachment connecting the role and the least-privilege policy

## Architecture

- `data.aws_iam_policy_document.s3_read_only` builds the scoped S3 policy.
- `data.aws_iam_policy_document.assume_role` defines which service principals may assume the role.
- `aws_iam_policy.s3_read_only` creates a reusable customer-managed policy.
- `aws_iam_role.this` creates the role.
- `aws_iam_role_policy_attachment.attach_s3_read_only` attaches the policy to the role.

## Engineering Choices

- The policy is bucket-scoped instead of account-wide.
- Trust is explicit through `trusted_service_principals`.
- The module keeps the policy small enough for line-by-line review.
- Inputs are validated so empty role names, bucket names, and trust lists fail early.
- Provider configuration is kept minimal for simple local review, but production consumers should pass provider configuration from the root module.

## Security And Reliability Controls

- Least-privilege S3 read access.
- No wildcard bucket access.
- No S3 write or delete permissions.
- Explicit role trust policy.
- CI checks for Terraform formatting, validation, linting, and security scanning.

## Current Limitations

This is not a full AWS account IAM baseline. It does not currently enforce MFA, password policy, CloudTrail, Organizations SCPs, region restrictions, IAM Access Analyzer, or human-user lifecycle controls.

## What This Shows

This repo demonstrates a concrete IAM least-privilege pattern that a reviewer can verify quickly. It is strongest when presented as a focused module, not as a full account security baseline.

## Next Improvements

- Add Terraform tests that assert exact IAM policy actions and resources.
- Add an example for Lambda or EC2 consumption.
- Remove provider configuration from the module and document root-module provider usage.
- Add an optional external ID condition for cross-account assumptions.
- Build a separate full IAM account-baseline module if MFA, password policy, CloudTrail, and region governance are required.
