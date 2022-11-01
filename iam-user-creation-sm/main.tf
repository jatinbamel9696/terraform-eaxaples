
resource "aws_iam_user" "user" {
  name = "test-user"
}

resource "aws_iam_access_key" "test" {
  user = aws_iam_user.user.name
}

resource "aws_secretsmanager_secret" "test1" {
  name = "aws_iam_access"
  description = "My credentials"
}

resource "aws_secretsmanager_secret_version" "test1" {
  secret_id     = aws_secretsmanager_secret.test1.id
  secret_string = jsonencode({ "UserName" = aws_iam_user.user.name, "AccessKeyID" = aws_iam_access_key.test.id, "SecretAccessKey" = aws_iam_access_key.test.secret})
}



resource "aws_iam_policy" "policy" {
  name        = "iam_key_auto_rotation"
  path        = "/"
  description = "iam_key_auto_rotation"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "VisualEditor0",
        "Effect" : "Allow",
        "Action" : [
          "iam:DeleteAccessKey",
          "secretsmanager:GetSecretValue",
          "iam:UpdateAccessKey",
          "secretsmanager:ListSecrets",
          "secretsmanager:UpdateSecret",
          "iam:CreateAccessKey",
          "iam:ListAccessKeys"
        ],
        "Resource" : "*"
      }
    ]
  })
}

data "aws_iam_policy" "AWSLambdaBasicExecutionRole" {
  arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role" "role" {
  name = "key_rotation"
  assume_role_policy = jsonencode({
    
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "lambda.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]

  })

  tags = {
    env = "test"
  }
}

resource "aws_iam_role_policy_attachment" "role_policy" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.policy.arn
}






