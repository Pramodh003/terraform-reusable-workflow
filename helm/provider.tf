terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }
  }
}
provider "kubernetes" {
  config_path = "C:/Users/pramo/.kube/config"
}
provider "helm" {
  kubernetes {
    config_path = "C:/Users/pramo/.kube/config"
  }
}




