resource "aws_dynamodb_table" "lock" {
  name           = var.thisbucket
  hash_key       = "LockID"
  read_capacity  = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "${var.thisbucket}"
    Owner       = var.owner
    Purpose     = "Remote State Lock Table ${var.thisbucket}"
    EOLDate     = var.eoldate
    Environment = var.environment
    Prod        = var.isprod
    CostCenter  = var.costcenter
    Source      = var.src

  }
}
