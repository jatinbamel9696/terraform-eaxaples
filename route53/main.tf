module "r53-outboud-endpoint" {
  source = "././r53-outbond-endpoint"
  allowed_resolvers = ["10.0.0.0/20", "10.0.16.0/20"]
  direction         = "outbound"
  vpc_id            = "vpc-05a98eecc9762926f"

  ip_addresses      = [
    {
      subnet_id = "subnet-017fefd5ae248f35b"
      ip  = "10.0.0.25"
    },
    {
      subnet_id = "subnet-0eb9999e88c924b00"
      ip = "10.0.16.25"
    }
  ]
  tags = {
    env = "test"
  }
}

# Create a rule and assign it to a given VPC
module "route53-rule1" {
  source            = "././r53-resolver_rule"
  associated_vpcs   = ["vpc-05a98eecc9762926f"]
  forward_domain    = "test-example.com."
  forward_ips       = ["10.0.0.26", "10.0.16.26"]
  resolver_endpoint = module.outboud-endpoint.endpoint_id
  #resource_share_accounts = ["373951541525"]
  tags = {
    env = "test"
  }
}
/*
# Create a rule without VPC assignment(and share it via RAM)
module "route53-rule-ad-corp" {
  source            = "git::https://github.com/rhythmictech/terraform-aws-route53-resolver-rule?ref=v0.0.2"
  forward_domain    = "ad.mycompany.com."
  forward_ips       = ["192.168.100.10", "192.168.100.11"]
  resolver_endpoint = module.route53-outbound.endpoint_id
}

*/




