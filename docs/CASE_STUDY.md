# Case Study: Terraform AWS IAM Baseline

## Problem

AWS accounts can quickly accumulate broad permissions, weak human-user controls, and unclear audit access. This module demonstrates a small but important IAM baseline for accounts that need secure defaults before application teams start building.

## Solution

The module applies account-level IAM hardening, including password policy controls, MFA enforcement for human users, an audit role, and region restrictions for unused regions.

## Architecture

- Terraform module for repeatable IAM configuration.
- Password policy resources for account hardening.
- MFA enforcement policy for interactive users.
- Read-only audit role with CloudTrail access.
- Deny policy for unused AWS regions.

## Engineering Choices

- The baseline focuses on controls that are easy to review and explain.
- Terraform keeps IAM changes versioned and reproducible.
- MFA enforcement separates human-user hardening from service-role design.
- Audit role access supports security review without giving broad admin rights.

## Security And Reliability Controls

- Least-privilege audit access.
- Stronger password policy.
- MFA requirements for human users.
- Region restriction to reduce accidental exposure.
- Infrastructure-as-code review path for IAM changes.

## What This Shows

This repo demonstrates cloud security fundamentals that matter in client delivery: identity, least privilege, auditability, and repeatable infrastructure.

It pairs well with the secure VPC module because together they show both network and identity foundations.

## Next Improvements

- Add example account configurations.
- Add IAM Access Analyzer validation notes.
- Add automated checks with `terraform validate`, `tflint`, and `checkov`.
- Add diagrams for human-user, service-role, and audit-role boundaries.
