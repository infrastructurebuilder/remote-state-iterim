

data "aws_iam_policy_document" "read_state_bucket" {
  statement {
    sid = "1"
    actions = [
      "s3:ListBucket",
    ]
    resources = [
      aws_s3_bucket.rsbbucket.arn
    ]
  }

  statement {
    actions = [
      "s3:ListObjects",
      "s3:GetObject"
    ]

    resources = [
      "${aws_s3_bucket.rsbbucket.arn}/@state.target.prefix@*"
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
      "${aws_s3_bucket.rsbbucket.arn}/@state.target.prefix@*"
    ]
  }

  statement {
    actions = [
      "s3:ListObjects",
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObjects",
      "s3:DeleteObject"
    ]

    resources = [
      "${aws_s3_bucket.rsbbucket.arn}/@state.target.prefix@*"
    ]
  }
}

resource "aws_iam_policy" "read_state_bucket_policy" {
  name_prefix     = "rsb-${aws_s3_bucket.rsbbucket.id}-read"
  path   = "/"
  policy = data.aws_iam_policy_document.read_state_bucket.json
  tags = {
    Purpose     = "Read ${aws_s3_bucket.rsbbucket.id}"
    Owner       = var.owner
    EOLDate     = var.eoldate
    Environment = var.environment
    Prod        = var.isprod
    CostCenter  = var.costcenter
    Source      = var.src
  }


}
resource "aws_iam_policy" "write_state_bucket_policy" {
  name_prefix   = "rsb-${aws_s3_bucket.rsbbucket.id}-write"
  path   = "/"
  policy = data.aws_iam_policy_document.write_state_bucket.json
  tags = {
#    Name        = "rsb-${aws_s3_bucket.rsbbucket.id}-write"
    Owner       = var.owner
    Purpose     = "Write ${aws_s3_bucket.rsbbucket.id}"
    EOLDate     = var.eoldate
    Environment = var.environment
    Prod        = var.isprod
    CostCenter  = var.costcenter
    Source      = var.src
  }
}

resource "aws_iam_role" "read_state_role" {
  name               = "rsb-${aws_s3_bucket.rsbbucket.id}-read"
  path               = "/"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Principal" : { "AWS":"*" },
            "Action": "sts:AssumeRole",
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
  tags = {
    Purpose     = "Allows reads from ${aws_s3_bucket.rsbbucket.id} State Bucket"
    Owner       = var.owner
    EOLDate     = var.eoldate
    Environment = var.environment
    Prod        = var.isprod
    CostCenter  = var.costcenter
    Source      = var.src
  }
}

resource "aws_iam_role_policy_attachment" "attach_read_state_role" {
  role = aws_iam_role.read_state_role.name
  policy_arn =  aws_iam_policy.read_state_bucket_policy.arn

}
resource "aws_iam_role" "write_state_role" {
  name               = "rsb-${aws_s3_bucket.rsbbucket.id}-write"
  path               = "/"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Principal" : { "AWS":"*" },
            "Action": "sts:AssumeRole",
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
  tags = {
    Purpose     = "Allows writes to ${aws_s3_bucket.rsbbucket.id} State Bucket"
    Owner       = var.owner
    EOLDate     = var.eoldate
    Environment = var.environment
    Prod        = var.isprod
    CostCenter  = var.costcenter
    Source      = var.src
  }
}
resource "aws_iam_role_policy_attachment" "attach_write_state_role" {
  role = aws_iam_role.write_state_role.name
  policy_arn =  aws_iam_policy.write_state_bucket_policy.arn

}



data "aws_iam_policy_document" "read_logging_bucket" {
  statement {
    sid = "1"
    actions = [
      "s3:ListBucket",
    ]
    resources = [
      aws_s3_bucket.logbucket.arn
    ]
  }

  statement {
    actions = [
      "s3:GetObject",
    ]

    resources = [
      "${aws_s3_bucket.logbucket.arn}/@logging.target.prefix@*"
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
      "${aws_s3_bucket.logbucket.arn}/@logging.target.prefix@*"
    ]
  }

  statement {
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]

    resources = [
      "${aws_s3_bucket.logbucket.arn}/@logging.target.prefix@*"
    ]
  }
}

resource "aws_iam_policy" "read_logging_bucket_policy" {
  name   = "rsb-${aws_s3_bucket.logbucket.id}-read"
  path   = "/"
  policy = data.aws_iam_policy_document.read_logging_bucket.json
  tags = {
#    Name        = "rsb-${var.s3_bucket_name}-read"
    Purpose     = "Read ${aws_s3_bucket.logbucket.id}"
    Owner       = var.owner
    EOLDate     = var.eoldate
    Environment = var.environment
    Prod        = var.isprod
    CostCenter  = var.costcenter
    Source      = var.src
  }


}
resource "aws_iam_policy" "write_logging_bucket_policy" {
  name   = "rsb-${aws_s3_bucket.logbucket.id}-write"
  path   = "/"
  policy = data.aws_iam_policy_document.write_logging_bucket.json
  tags = {
    Purpose     = "Write ${aws_s3_bucket.logbucket.id}"
    Owner       = var.owner
    EOLDate     = var.eoldate
    Environment = var.environment
    Prod        = var.isprod
    CostCenter  = var.costcenter
    Source      = var.src
  }
}

resource "aws_iam_role" "read_logging_role" {
  name               = "rsb-${aws_s3_bucket.logbucket.id}-read"
  path               = "/"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Principal" : { "AWS":"*" },
            "Action": "sts:AssumeRole",
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
  tags = {
#    Name        = "${var.thisproject} Read Role"
    Purpose     = "Allows reads from ${aws_s3_bucket.logbucket.id} Bucket"
    Owner       = var.owner
    EOLDate     = var.eoldate
    Environment = var.environment
    Prod        = var.isprod
    CostCenter  = var.costcenter
    Source      = var.src
  }

}
resource "aws_iam_role" "write_logging_role" {
  name               = "rsb-${aws_s3_bucket.logbucket.id}-write"
  path               = "/"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Principal" : { "AWS":"*" },
            "Action": "sts:AssumeRole",
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
  tags = {
    Purpose     = "Allows writes to ${aws_s3_bucket.logbucket.id} Bucket"
    Owner       = var.owner
    EOLDate     = var.eoldate
    Environment = var.environment
    Prod        = var.isprod
    CostCenter  = var.costcenter
    Source      = var.src
  }
}

