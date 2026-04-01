variable "bucket_name" {
  description = "Name of the S3 bucket to grant read-only access to"
  type        = string

  validation {
    condition     = length(trim(var.bucket_name, " ")) > 0
    error_message = "bucket_name must not be empty."
  }
}

variable "role_name" {
  description = "Name of the IAM role to create"
  type        = string

  validation {
    condition     = length(trim(var.role_name, " ")) > 0
    error_message = "role_name must not be empty."
  }
}

variable "tags" {
  description = "Tags applied to IAM resources"
  type        = map(string)
  default     = {}
}

variable "trusted_service_principals" {
  description = "AWS service principals allowed to assume this role"
  type        = list(string)
  default     = ["ec2.amazonaws.com"]

  validation {
    condition     = length(var.trusted_service_principals) > 0
    error_message = "trusted_service_principals must include at least one service principal."
  }
}