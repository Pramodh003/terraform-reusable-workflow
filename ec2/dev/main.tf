terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.5.0"
     }
  }
}


module "ec2_vpc" {
    source = "../modules/vpc"
    vpc_cidr = "192.168.0.0/16"
    tenancy = "default"
    vpc_id = "${module.ec2_vpc.vpc_id}"
    subnet_cidr = "192.168.0.0/24"
  
}

module "myec2"{
    source = "../modules/ec2"
    count         = "1"
    ami_id           =  "ami-053b0d53c279acc90"
    instance_type = "t2.micro"
    subnet_id = "${module.ec2_vpc.subnet_id}"
}

