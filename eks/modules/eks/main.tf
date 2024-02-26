resource "aws_eks_cluster" "eks" {
  name     = var.PROJECT-NAME
  role_arn = var.cluster_role_arn
  version = 1.28
  vpc_config {
    endpoint_private_access = false
    endpoint_public_access = true
  
  subnet_ids = [
    var.pub_sub_1,
    var.pri_sub_1,
    var.pri_sub_2,
    var.pub_sub_2
  ]
  }
}