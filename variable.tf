variable "aws_users" {
    description = "List of users"
    type = object({
      name = string
      roles = list(string)
    })  
}

variable "permissions" {
  description = "The list of S3 permissions to allow"
  type        = list(string)
  default     = [
    "s3:GetObject",
    "s3:PutObject",
    "s3:ListBucket"
  ]
}