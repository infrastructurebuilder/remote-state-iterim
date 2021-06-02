data "aws_iam_policy_document" "read_bucket" {
  statement {
    sid = "1"
    actions = [
      "s3:ListBucket",
    ]
    resources = [
      "arn:aws:s3:::${var.s3_bucket_name}",
    ]
  }

  statement {
    actions = [
      "s3:GetObject",
    ]

    resources = [
      "arn:aws:s3:::${var.s3_bucket_name}/tfstate/*"
    ]
  }
}

data "aws_iam_policy_document" "read_bucket" {
  statement {
    sid = "1"
    actions = [
      "s3:ListBucket",
    ]
    resources = [
      "arn:aws:s3:::${var.s3_bucket_name}/tfstate/*",
    ]
  }

  statement {
    actions = [
      "s3:PutObject",
      "s3:DeleteObject"
    ]

    resources = [
      "arn:aws:s3:::${var.s3_bucket_name}/tfstate/*"
    ]
  }
}

resource "aws_iam_policy" "read_bucket_policy" {
  name   = "rsb-${var.s3_bucket_name}-read"
  path   = "/"
  policy = data.aws_iam_policy_document.read_bucket.json
  tags = {
#    Name        = "rsb-${var.s3_bucket_name}-read"
    Owner       = "${var.owner}"
    Purpose     = "${var.thispurpose}"
    EOLDate     = "${var.eoldate}"
    Environment = "${var.environment}"
    Prod        = "yes"
    CostCenter  = "${var.costcenter}"
    Source      = "${var.src}"
  }


}
resource "aws_iam_policy" "write_bucket_policy" {
  name   = "rsb-${var.s3_bucket_name}-write"
  path   = "/"
  policy = data.aws_iam_policy_document.write_bucket.json
  tags = {
#    Name        = "rsb-${var.s3_bucket_name}-write"
    Owner       = "${var.owner}"
    Purpose     = "${var.thispurpose}"
    EOLDate     = "${var.eoldate}"
    Environment = "${var.environment}"
    Prod        = "yes"
    CostCenter  = "${var.costcenter}"
    Source      = "${var.src}"
  }
}

resource "aws_iam_role" "readrole" {
  name               = "rsb-${var.s3_bucket_name}-read"
  path               = "/tfstate/"
  assume_role_policy = data.aws_iam_policy_document.read_bucket_policy.json
  tags = {
#    Name        = "${var.thisproject} Read Role"
    Owner       = "#operations"
    Purpose     = "Allows reads from ${var.s3_bucket_name} State Bucket"
    EOLDate     = "2050-12-31"
    Environment = "${var.environment}"
    Prod        = "yes"
    CostCenter  = "${var.costcenter}"
    Source      = "${var.src}"
  }

}
resource "aws_iam_role" "writerole" {
  name               = "rsb-${var.s3_bucket_name}-write"
  path               = "/tfstate/"
  tags = {
#    Name        = "${var.thisproject} Write Role"
    Owner       = "${var.owner}"
    Purpose     = "Allows writes to ${var.s3_bucket_name} State Bucket"
    EOLDate     = "2050-12-31"
    Environment = "${var.environment}"
    Prod        = "yes"
    CostCenter  = "${var.costcenter}"
    Source      = "${var.src}"
  }

  assume_role_policy = data.aws_iam_policy_document.read_bucket_policy.json
}
resource "aws_iam_role_policy_attachment" "write_attach" {
  role       = aws_iam_role.writerole.name
  policy_arn = aws_iam_policy.read_bucket_policy.arn
}
