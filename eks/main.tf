module "myvpc"{
    source = "./modules/vpc"
    vpc_cidr = var.vpc_cidr
    PROJECT-NAME = var.PROJECT-NAME
    public-subnet-1 = var.public-subnet-1
    public-subnet-2 = var.public-subnet-2
    private-subnet-1 = var.private-subnet-1
    private-subnet-2 = var.private-subnet-2
    region = var.region

}

module "mynat"{
    source = "./modules/nat-gateway"
    pub_sub_1  = module.myvpc.pub_sub_1
    pub_sub_2 = module.myvpc.pub_sub_2
    igw_id = module.myvpc.igw_id
    pri_sub_1 = module.myvpc.pri_sub_1
    pri_sub_2 = module.myvpc.pri_sub_2
    vpc_id  = module.myvpc.igw_id
}

module "iam"{
    source = "./modules/iam"
    PROJECT-NAME = var.PROJECT-NAME
}

module "cluster"{
    source = "./modules/eks"
    PROJECT-NAME = var.PROJECT-NAME
    cluster_role_arn = module.iam.cluster_role_arn
    pub_sub_1 = module.myvpc.pub_sub_1
    pub_sub_2 = module.myvpc.pub_sub_2
    pri_sub_1 = module.myvpc.pri_sub_1
    pri_sub_2 = module.myvpc.pri_sub_2

}

module "nodegroup" {
    source = "./modules/node-group"
    eks_cluster_name = module.cluster.eks_cluster_name
    node_group_role_arn = module.iam.node_group_role_arn
    pri_sub_1 = module.myvpc.pri_sub_1
    pri_sub_2 = module.myvpc.pri_sub_2
  
}