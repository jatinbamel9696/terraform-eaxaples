module "sg-csv" {
  source = "././sg-csv"
  vpc_id = "vpc-05a98eecc9762926f"
  sg_name = "test-sg"
  #sg_id = "sg-0f11fadd855cb48d6"
  tags = {
    env = "test"
  }
}