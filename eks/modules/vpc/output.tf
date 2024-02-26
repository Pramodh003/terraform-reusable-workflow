output "vpc_id" {
    value = aws_vpc.eks_vpc.id
}
output "pub_sub_1" {
    value = aws_subnet.public_subnet_1.id
}
output "pub_sub_2" {
    value = aws_subnet.public_subnet_2.id
}
output "pri_sub_1" {
    value = aws_subnet.private_subnet_1.id
}
output "pri_sub_2" {
    value = aws_subnet.private_subnet_1.id
}

output "igw_id" {
    value = aws_internet_gateway.eks-igw.id
}
output "region" {
  value = var.region
}
