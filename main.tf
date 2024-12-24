resource "aws_iam_user" "user" {
    name = var.aws_users.name

    tags = {
        name = var.aws_users.name
    }
}

resource "aws_iam_account_password_policy" "user-pass-policy" {
  minimum_password_length    = 10
  require_symbols            = true
  require_numbers            = true
  require_uppercase_characters   = true  # Corrected
  require_lowercase_characters   = true  # Corrected
  allow_users_to_change_password = true
  max_password_age          = 90
  password_reuse_prevention = 5
}

resource "aws_iam_user_login_profile" "user-login" {
    user = aws_iam_user.user.name
    password_length = 10
    password_reset_required = true
}