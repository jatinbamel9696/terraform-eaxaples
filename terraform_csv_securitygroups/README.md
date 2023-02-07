##Usages

module "sg-csv" {
  source = "././sg-csv"
  vpc_id = "vpc-12345"
  sg_name = "test-sg"
  #sg_id = "sg-012345"
  tags = {
    env = "test"
  }
}