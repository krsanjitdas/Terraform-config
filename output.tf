output "iam_nameoutput" {
    value = aws_iam_user.user.name
}

output "iam_user_pass" {
    value = aws_iam_user_login_profile.user-login.encrypted_password
}

output "S3_bucket" {
    value = aws_s3_bucket.s3-buck.arn
}