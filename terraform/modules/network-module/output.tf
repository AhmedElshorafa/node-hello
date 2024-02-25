output "vpc-id" {
  value = aws_vpc.vpc.id
}
output "public-subnets" {
  value = aws_subnet.public_subnets[*].id
}

output "private-subnets" {
  value = aws_subnet.private_subnets[*].id
}
