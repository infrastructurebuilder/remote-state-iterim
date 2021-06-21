resource "aws_dynamodb_table" "lock" {
  name           = "rsb-${var.thisbucket}-lock"
  hash_key       = "LockID"
  read_capacity  = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "rsb-${var.thisbucket}-lock"
    Owner       = var.owner
    Purpose     = "Remote State Lock Table for rsb-${var.thisbucket}"
    EOLDate     = var.eoldate
    Environment = var.environment
    Prod        = var.isprod
    CostCenter  = var.costcenter
    Source      = var.src

  }
}
