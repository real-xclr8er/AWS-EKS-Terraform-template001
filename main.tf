module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = "${var.project_prefix}-${var.cluster_name}-vpc"
  cidr = var.vpc_cidr

  azs             = ["${var.aws_region}a", "${var.aws_region}b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(
    var.tags,
    {
      "kubernetes.io/cluster/${var.project_prefix}-${var.cluster_name}" = "shared"
    }
  )

  private_subnet_tags = {
    "kubernetes.io/cluster/${var.project_prefix}-${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"                                = "1"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${var.project_prefix}-${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                                         = "1"
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = "${var.project_prefix}-${var.cluster_name}"
  cluster_version = var.cluster_version

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  cluster_endpoint_public_access = true

  eks_managed_node_groups = {
    default = {
      min_size     = var.min_size
      max_size     = var.max_size
      desired_size = var.desired_size

      instance_types = var.instance_types
      capacity_type  = "SPOT"

      labels = {
        Environment = var.environment
      }

      tags = var.tags
    }
  }

  cluster_addons = {
    aws-ebs-csi-driver = {
      most_recent = true
    }
  }

  tags = merge(
    var.tags,
    {
      Environment = var.environment
    }
  )
}
