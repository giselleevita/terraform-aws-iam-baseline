variable "bucket_name" {
  description = "Name of the S3 bucket to grant read-only access to"
  type        = string

  validation {
    condition     = length(var.bucket_name) >= 3 && length(var.bucket_name) <= 63 && can(regex("^[a-z0-9][a-z0-9.-]*[a-z0-9]$", var.bucket_name)) && !strcontains(var.bucket_name, "..") && !can(regex("^(?:[0-9]{1,3}\\.){3}[0-9]{1,3}$", var.bucket_name))
    error_message = "bucket_name must meet AWS S3 naming rules and must not be an IP address."
  }
}

variable "role_name" {
  description = "Name of the IAM role to create"
  type        = string

  validation {
    condition     = length(var.role_name) >= 1 && length(var.role_name) <= 64 && can(regex("^[A-Za-z0-9+=,.@_-]+$", var.role_name))
    error_message = "role_name must be 1-64 characters using AWS IAM's allowed character set."
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
    condition     = length(var.trusted_service_principals) > 0 && length(distinct(var.trusted_service_principals)) == length(var.trusted_service_principals) && alltrue([for principal in var.trusted_service_principals : can(regex("^[a-z0-9-]+(?:\\.[a-z0-9-]+)*\\.amazonaws\\.com(?:\\.cn)?$", principal))])
    error_message = "trusted_service_principals must contain unique AWS service principals such as ec2.amazonaws.com."
  }
}
