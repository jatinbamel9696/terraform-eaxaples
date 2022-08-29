

resource "aws_directory_service_directory" "my_simplead" {
  type     = "SimpleAD"
  name     = "awsjat.com"
  size     = "Small"
  password = var.ec2-password
  #jsondecode(data.aws_secretsmanager_secret_version.current_secrets.secret_string)["password"]

  vpc_settings {
    vpc_id     =  "vpc-05a98eecc9762926f"
    subnet_ids =  ["subnet-0c89adec80d57fe66", "subnet-058749a930e410305"]  
  }
}


