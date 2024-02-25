output "vpc-id" {
  value = module.network.vpc-id
}

output "public-subnets" {
  value = module.network.public-subnets[*]
}

output "private-subnets" {
  value = module.network.private-subnets[*]
}