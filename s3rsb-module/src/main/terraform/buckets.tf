resource "aws_kms_key" "encryptionkey" {
  description             = "${var.thisbucket} Encryption Key"
  deletion_window_in_days = 30
  enable_key_rotation     = true
  # tags = {
  #   Name        = "${var.thisbucket} Encryption Key"
  #   Owner       = "${var.owner}"
  #   Purpose     = "Encryption Key for ${var.thisproject}"
  #   EOLDate     = "${var.eoldate}"
  #   Environment = "${var.environment}"
  #   Prod        = "${var.isprod}"
  #   CostCenter  = "${var.costcenter}"
  #   Source      = "${var.src}"
  # }
}

resource "aws_s3_bucket" "logbucket" {
  bucket = "rsb-${var.thisbucket}-log"
  acl    = "log-delivery-write"

  tags = {
    Owner       = "${var.owner}"
    Purpose     = "Logging Bucket for ${var.thisbucket}"
    EOLDate     = "${var.eoldate}"
    Environment = "${var.environment}"
    Prod        = "${var.isprod}"
    CostCenter  = "${var.costcenter}"
    Source      = "${var.src}"
  }

  versioning {
    enabled = true
  }


  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.encryptionkey.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }

  lifecycle_rule {
    id = "statebucketlogging"
    prefix  = "@logging.target.prefix@"
    enabled = true

    transition {
      days = 30
      storage_class = "STANDARD_IA"
    }

    transition {
      days = 60
      storage_class = "GLACIER"
    }

    noncurrent_version_transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    noncurrent_version_transition {
      days          = 60
      storage_class = "GLACIER"
    }

  }
}


resource "aws_s3_bucket" "rsbbucket" {
  bucket = "rsb-${var.thisbucket}"
  acl    = "private"

  tags = {
    Name        = "${var.thisbucket}"
    Owner       = "${var.owner}"
    Purpose     = "Remote State Bucket for ${var.thisproject}"
    EOLDate     = "${var.eoldate}"
    Environment = "${var.environment}"
    Prod        = "${var.isprod}"
    CostCenter  = "${var.costcenter}"
    Source      = "${var.src}"
  }

  versioning {
    enabled = true
  }

  logging {
    target_bucket = aws_s3_bucket.logbucket.id
    target_prefix = "@logging.target.prefix@"

  }


  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.encryptionkey.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }

  lifecycle_rule {
    id = "statebucketlogging"
    prefix  = "@state.target.prefix@"
    enabled = true

    transition {
      days = 30
      storage_class = "STANDARD_IA"
    }

    noncurrent_version_transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

  }
}
