resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = var.eks_cluster_name
  node_group_name = "${var.eks_cluster_name}-node_group"
  node_role_arn   = var.node_group_role_arn
  subnet_ids = [
    var.pri_sub_1,
    var.pri_sub_2
  ]

  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 2
  }

  ami_type       = "AL2_x86_64"
  instance_types = ["t3.micro"]
  capacity_type  = "ON_DEMAND"
  disk_size      = 20

  force_update_version = false

  labels = {
    role = "${var.eks_cluster_name}-Node-group-role",
    name = "${var.eks_cluster_name}-Node-group"
  }

  version = "1.28"
}
