data "aws_iam_policy_document" "s3_read_only" {
  statement {
    sid    = "AllowListSpecificBucket"
    effect = "Allow"

    actions = [
      "s3:ListBucket"
    ]

    resources = [
      "arn:aws:s3:::${var.bucket_name}"
    ]
  }

  statement {
    sid    = "AllowReadObjectsInSpecificBucket"
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion"
    ]

    resources = [
      "arn:aws:s3:::${var.bucket_name}/*"
    ]
  }
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    sid     = "AllowServiceAssumeRole"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = var.trusted_service_principals
    }
  }
}

resource "aws_iam_policy" "s3_read_only" {
  name        = "${var.role_name}-s3-read-only"
  description = "Least-privilege read-only access to S3 bucket ${var.bucket_name}"
  policy      = data.aws_iam_policy_document.s3_read_only.json
  tags        = var.tags
}

resource "aws_iam_role" "this" {
  name               = var.role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  tags               = var.tags
}

resource "aws_iam_role_policy_attachment" "attach_s3_read_only" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.s3_read_only.arn
}