resource "aws_kms_key" "encryptionkey" {
  description             = "${var.thisproject} Encryption Key"
  deletion_window_in_days = 30
  enable_key_rotation     = true
}

resource "aws_s3_bucket" "logbucket" {
  bucket = "${var.thisproject}-log"
  acl    = "private"

  tags = {
    Name        = "${var.thisproject} Logging Bucket"
    Owner       = "#operations"
    Purpose     = "Holds logs for ${var.thisproject} State Bucket"
    EOLDate     = "2050-12-31"
    Environment = "${var.environment}"    
    Prod        = "yes"
    CostCenter  = "devsecops"
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


