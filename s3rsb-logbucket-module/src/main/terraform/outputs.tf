output "rslogbucket" {
    value = aws_s3_bucket.logbucket
}

output "encryptionkey_arn" {
    value = aws_kms_key.encryptionkey.arn
}

