output "rsbbucket" {
    value = aws_s3_bucket.thebucket
}

output "encryptionkey_arn" {
    value = aws_kms_key.encryptionkey.arn
}

