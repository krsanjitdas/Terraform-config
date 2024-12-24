resource "random_id" "rand_id" {
    byte_length = 8
  }

resource "aws_s3_bucket" "s3-buck" {
    bucket = "var.aws_users.name-${random_id.rand_id.hex}"
}

resource "aws_s3_object" "s3-obj" {
   bucket = aws_s3_bucket.s3-buck.bucket
   source = "./file.txt"
   key = "file.txt"
}

# Define an IAM Policy for S3 Bucket Access
resource "aws_iam_policy" "s3_bucket_policy" {
  name        = "${var.aws_users.name}-s3-bucket-policy"
  description = "Policy to allow access to a specific S3 bucket"
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = var.permissions
        Resource = [
          aws_s3_bucket.s3-buck.arn,
          "${aws_s3_bucket.s3-buck.arn}/*" # Include objects in the bucket
        ]
      }
    ]
  })
}

# Attach the Policy to the User
resource "aws_iam_user_policy_attachment" "user_policy_attachment" {
  user       = aws_iam_user.user.name
  policy_arn = aws_iam_policy.s3_bucket_policy.arn
}
