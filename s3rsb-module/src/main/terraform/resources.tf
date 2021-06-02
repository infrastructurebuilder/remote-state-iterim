resource "aws_kms_key" "encryptionkey" {
  description             = "${var.thisbucket} Encryption Key"
  deletion_window_in_days = 30
  enable_key_rotation     = true
  tags = {
    Name        = "${var.thisbucket} Encryption Key"
    Owner       = "${var.owner}"
    Purpose     = "${var.thispurpose}"
    EOLDate     = "${var.eoldate}"
    Environment = "${var.environment}"
    Prod        = "yes"
    CostCenter  = "${var.costcenter}"
    Source      = "${var.src}"
  }
}

resource "aws_s3_bucket" "thebucket" {
  bucket = "${var.thisbucket}"
  acl    = "private"

  tags = {
    Name        = "${var.thisbucket}"
    Owner       = "${var.owner}"
    Purpose     = "${var.thispurpose}"
    EOLDate     = "${var.eoldate}"
    Environment = "${var.environment}"
    Prod        = "yes"
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
    prefix  = "rsblogs/"
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


