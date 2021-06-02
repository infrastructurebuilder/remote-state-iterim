output "encryptionkey_arn" {
    value = aws_kms_key.encryptionkey.arn
}

output "statebucket" {
    value = aws_s3_bucket.rsbbucket
}


output "logbucket" {
    value = aws_s3_bucket.logbucket
}

output "read_rsb_role" {
    value = aws_iam_role.read_state_role
}

output "write_rsb_role" {
    value = aws_iam_role.write_state_role
}

output "read_log_role" {
    value = aws_iam_role.read_logging_role
}

output "write_log_role" {
    value = aws_iam_role.write_logging_role
}
