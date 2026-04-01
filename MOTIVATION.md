# Why This Module Exists

## The Problem

Most AWS accounts suffer from permission creep. A developer gets an S3 access policy that was "quick to set up" and ends up with read access to 50 buckets, write access they don't need, and no audit trail.

This creates two risks:
1. Blast radius: if credentials leak, the attacker has access to far more than intended
2. Compliance: auditors see overpermission and flag it as a control failure

## The Solution

This module demonstrates what **least privilege actually looks like** in Terraform:

- One policy for one bucket
- Read-only actions (GetObject, ListBucket only)
- Explicit resource ARNs, never wildcards
- Clear, reviewable intent in code

## Key Design Decisions

### Why data sources for policy documents?
Data sources let you write policy in HCL instead of JSON strings. This is easier to read, version control, and review in pull requests.

### Why separate policy and role?
The policy can be reused across multiple roles. The role defines trust (who assumes it), the policy defines permissions (what they can do). Keeping them separate follows the principle of single responsibility.

### Why configurable service principals?
A baseline should adapt. You might run on EC2 today, Lambda tomorrow. The module lets you change assumed principals without refactoring the whole structure.

## Real-World Usage

This pattern scales to larger infrastructures:
- Data team: read-only access to analytics S3 bucket
- CI/CD pipeline: write-only access to artifact repository bucket
- Audit function: comprehensive read access across compliance buckets

Each role gets exactly the permissions it needs. No exceptions.

## Learning Outcome

If you understand this module, you understand:
- How IAM policies are scoped
- Why wildcards are dangerous
- How to design roles that are auditable and secure

That knowledge transfers to every AWS account you'll ever touch.
