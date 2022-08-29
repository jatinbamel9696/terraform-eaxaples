/*
output "arn" {
  description = "The ARN of the Secrets Manager secret."
  value       = aws_secretsmanager_secret.ec2-sm.arn
}

output "id" {
  description = "The ID of the Secrets Manager secret."
  value       = aws_secretsmanager_secret.ec2-sm.id
}

output "name" {
  description = "The name of the secret."
  value       = aws_secretsmanager_secret.ec2-sm.name
}
*/
output "ec2-sm-password" {
  value = jsondecode(data.aws_secretsmanager_secret_version.current_secrets.secret_string)["password"]
}