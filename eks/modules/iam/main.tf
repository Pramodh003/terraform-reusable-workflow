resource "aws_iam_role" "eks_cluster_role" {
  name = "${var.PROJECT-NAME}-eks-role"

   assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy_access" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
    role = aws_iam_role.eks_cluster_role.name
}

resource "aws_iam_role_policy_attachment" "elb_full_access" {
    policy_arn = "arn:aws:iam::aws:policy/ElasticLoadBalancingFullAccess"
    role = aws_iam_role.eks_cluster_role.name
}

resource "aws_iam_role" "eks_node_group" {
  name = "${var.PROJECT-NAME}-node-group-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      }, 
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eks_worker_node_access" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
    role = aws_iam_role.eks_node_group.name
}

resource "aws_iam_role_policy_attachment" "eks_cni" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
    role = aws_iam_role.eks_node_group.name
}

resource "aws_iam_role_policy_attachment" "eks_container" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
    role = aws_iam_role.eks_node_group.name
}