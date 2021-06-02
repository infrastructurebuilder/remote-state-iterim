
data "aws_iam_policy_document" "read_state_bucket" {
  statement {
    sid = "1"
    actions = [
      "s3:ListBucket",
    ]
    resources = [
      aws_s3_bucket.rsbbucket.ARN
    ]
  }

  statement {
    actions = [
      "s3:GetObject",
    ]

    resources = [
      "${aws_s3_bucket.rsbbucket.ARN}/@state.target.prefix@*"
    ]
  }
}

data "aws_iam_policy_document" "write_state_bucket" {
  statement {
    sid = "1"
    actions = [
      "s3:ListBucket",
    ]
    resources = [
      "${aws_s3_bucket.rsbbucket.ARN}/@state.target.prefix@*"
    ]
  }

  statement {
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]

    resources = [
      "${aws_s3_bucket.rsbbucket.ARN}/@state.target.prefix@*"
    ]
  }
}

resource "aws_iam_policy" "read_state_bucket_policy" {
  name   = "rsb-${aws_s3_bucket.rsbbucket.name}-read"
  path   = "/"
  policy = data.aws_iam_policy_document.read_state_bucket.json
  tags = {
#    Name        = "rsb-${var.s3_bucket_name}-read"
    Owner       = "${var.owner}"
    Purpose     = "${var.thispurpose}"
    EOLDate     = "${var.eoldate}"
    Environment = "${var.environment}"
    Prod        = "${var.isprod}"
    CostCenter  = "${var.costcenter}"
    Source      = "${var.src}"
  }


}
resource "aws_iam_policy" "write_state_bucket_policy" {
  name   = "rsb-${aws_s3_bucket.rsbbucket.name}-write"
  path   = "/"
  policy = data.aws_iam_policy_document.write_state_bucket.json
  tags = {
#    Name        = "rsb-${var.s3_bucket_name}-write"
    Owner       = "${var.owner}"
    Purpose     = "${var.thispurpose}"
    EOLDate     = "${var.eoldate}"
    Environment = "${var.environment}"
    Prod        = "${var.isprod}"
    CostCenter  = "${var.costcenter}"
    Source      = "${var.src}"
  }
}

resource "aws_iam_role" "read_state_role" {
  name               = "rsb-${var.s3_bucket_name}-read"
  path               = "/@state.target.prefix@"
  assume_role_policy = data.aws_iam_policy_document.read_state_bucket.json
  tags = {
#    Name        = "${var.thisproject} Read Role"
    Owner       = "${var.owner}"
    Purpose     = "Allows reads from ${var.s3_bucket_name} State Bucket"
    EOLDate     = "${var.eoldate}"
    Environment = "${var.environment}"
    Prod        = "${var.isprod}"
    CostCenter  = "${var.costcenter}"
    Source      = "${var.src}"
  }

}
resource "aws_iam_role" "write_state_role" {
  name               = "rsb-${var.s3_bucket_name}-write"
  path               = "/@state.target.prefix@"
  assume_role_policy = data.aws_iam_policy_document.write_state_bucket.json
  tags = {
    Owner       = "${var.owner}"
    Purpose     = "Allows writes to ${var.s3_bucket_name} State Bucket"
    EOLDate     = "${var.eoldate}"
    Environment = "${var.environment}"
    Prod        = "${var.isprod}"
    CostCenter  = "${var.costcenter}"
    Source      = "${var.src}"
  }
}



data "aws_iam_policy_document" "read_logging_bucket" {
  statement {
    sid = "1"
    actions = [
      "s3:ListBucket",
    ]
    resources = [
      aws_s3_bucket.logbucket.ARN
    ]
  }

  statement {
    actions = [
      "s3:GetObject",
    ]

    resources = [
      "${aws_s3_bucket.logbucket.ARN}/@logging.target.prefix@*"
    ]
  }
}

data "aws_iam_policy_document" "write_logging_bucket" {
  statement {
    sid = "1"
    actions = [
      "s3:ListBucket",
    ]
    resources = [
      "${aws_s3_bucket.logbucket.ARN}/@logging.target.prefix@*"
    ]
  }

  statement {
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]

    resources = [
      "${aws_s3_bucket.logbucket.ARN}/@logging.target.prefix@*"
    ]
  }
}

resource "aws_iam_policy" "read_logging_bucket_policy" {
  name   = "rsb-${aws_s3_bucket.logbucket.name}-read"
  path   = "/"
  policy = data.aws_iam_policy_document.read_logging_bucket.json
  tags = {
#    Name        = "rsb-${var.s3_bucket_name}-read"
    Owner       = "${var.owner}"
    Purpose     = "${var.thispurpose}"
    EOLDate     = "${var.eoldate}"
    Environment = "${var.environment}"
    Prod        = "${var.isprod}"
    CostCenter  = "${var.costcenter}"
    Source      = "${var.src}"
  }


}
resource "aws_iam_policy" "write_logging_bucket_policy" {
  name   = "rsb-${aws_s3_bucket.logbucket.name}-write"
  path   = "/"
  assume_role_policy = data.aws_iam_policy_document.write_logging_bucket.json
  tags = {
    Owner       = "${var.owner}"
    Purpose     = "${var.thispurpose}"
    EOLDate     = "${var.eoldate}"
    Environment = "${var.environment}"
    Prod        = "${var.isprod}"
    CostCenter  = "${var.costcenter}"
    Source      = "${var.src}"
  }
}

resource "aws_iam_role" "read_logging_role" {
  name               = "rsb-${var.s3_bucket_name}-log-read"
  path               = "/@logging.target.prefix@"
  assume_role_policy = data.aws_iam_policy_document.read_logging_bucket.json
  tags = {
#    Name        = "${var.thisproject} Read Role"
    Owner       = "${var.owner}"
    Purpose     = "Allows reads from ${var.s3_bucket_name}-log Bucket"
    EOLDate     = "${var.eoldate}"
    Environment = "${var.environment}"
    Prod        = "${var.isprod}"
    CostCenter  = "${var.costcenter}"
    Source      = "${var.src}"
  }

}
resource "aws_iam_role" "write_logging_role" {
  name               = "rsb-${var.s3_bucket_name}-log-write"
  path               = "/@logging.target.prefix@"
  assume_role_policy = data.aws_iam_policy_document.write_logging_bucket.json
  tags = {
    Owner       = "${var.owner}"
    Purpose     = "Allows writes to ${var.s3_bucket_name}-log Bucket"
    EOLDate     = "${var.eoldate}"
    Environment = "${var.environment}"
    Prod        = "${var.isprod}"
    CostCenter  = "${var.costcenter}"
    Source      = "${var.src}"
  }
}

