output "terra-vpc" {
    description = "vpc detils"
    value = aws_vpc.terra_vpc.id
}

output "internet_gateway" {
    value = aws_internet_gateway.terra_igw.id
    description = "internet gateway detail"
}

output "public_subnet" {
    description = "public subnet details"
    value = zipmap(aws_subnet.public[*].cidr_block, aws_subnet.public[*].id)  ## zipmap(keyslist, valueslist)
}

output "security_group_public" {
  value = aws_security_group.public-sg.id
}

output "test-instance-public-ip" {
  value = aws_instance.test-instance.id
}

