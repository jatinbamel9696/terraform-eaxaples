resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "aws_secretsmanager_secret" "ec2-sm3" {
  name = "ec2-sm3"
}

# Creating a AWS secret versions for ec2 Instance
 
resource "aws_secretsmanager_secret_version" "sversion" {
  secret_id = aws_secretsmanager_secret.ec2-sm3.id
  secret_string = <<EOF
   {
    "username": "admin",
    "password": "${random_password.password.result}"
   }
EOF
}


# Importing the AWS secrets created previously using arn.
 
data "aws_secretsmanager_secret" "ec2-sm3" {
  arn = aws_secretsmanager_secret.ec2-sm3.arn
}



data "aws_secretsmanager_secret_version" "current_secrets" {
  secret_id = data.aws_secretsmanager_secret.ec2-sm3.id
}
