resource "aws_iam_user" "user" {
  name = "test-user"
}
resource "aws_iam_access_key" "test" {
  user = aws_iam_user.user.name
}

resource "aws_secretsmanager_secret" "test1" {
  name = "credentials1"
  description = "My credentials"
}

resource "aws_secretsmanager_secret_version" "test1" {
  secret_id     = aws_secretsmanager_secret.test1.id
  secret_string = jsonencode({ "AccessKey" = aws_iam_access_key.test.id, "SecretAccessKey" = aws_iam_access_key.test.secret})
}



