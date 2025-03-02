provider "aws" {
  region = var.aws_region
}

data "aws_eks_cluster_auth" "cluster" {
  name = "${var.project_prefix}-${var.cluster_name}"  // This should match your EKS cluster name exactly
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = ["eks", "get-token", "--cluster-name", "${var.project_prefix}-${var.cluster_name}"]
  }
}

provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      args        = ["eks", "get-token", "--cluster-name", "${var.project_prefix}-${var.cluster_name}"]
    }
  }
}
