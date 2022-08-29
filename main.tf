module "simple-ad" {
    source = "./ad"
    ec2-password = module.sm.ec2-sm-password
}

module "sm" {
    source = "./sm"
}

