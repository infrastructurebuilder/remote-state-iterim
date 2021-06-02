output "write_role" {
    value = aws_iam_role.writerole.name
}

output "read_role" {
    value = aws_iam_role.readrole.name
}

