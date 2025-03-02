resource "aws_eks_node_group" "primary" {
  cluster_name    = module.eks.cluster_name
  node_group_name = "${var.project_prefix}-node-group"
  node_role_arn   = module.eks.eks_managed_node_groups["default"].iam_role_arn  // Reference the IAM role output from the EKS module

  subnet_ids = module.vpc.private_subnets  // Reference the private subnets output from the VPC module
  
  scaling_config {
    desired_size = 2
    min_size     = 1
    max_size     = 3
  }

  instance_types = ["t3.medium"]
  capacity_type  = "SPOT"  // Use "ON_DEMAND" if you prefer; SPOT for cost savings
  
  disk_size = 20  // Disk size in GB

  taint {
    key    = "monitoring"
    value  = "true"
    effect = "NO_SCHEDULE"
  }

  labels = {
    role = "monitoring"
  }

  tags = {
    Name        = "${var.project_prefix}-node-group"
    Environment = "dev"
  }
}
