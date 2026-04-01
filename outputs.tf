output "policy_arn" {
  description = "ARN of the least-privilege S3 read-only IAM policy"
  value       = aws_iam_policy.s3_read_only.arn
}

output "role_name" {
  description = "Name of the IAM role with attached S3 read-only policy"
  value       = aws_iam_role.this.name
}