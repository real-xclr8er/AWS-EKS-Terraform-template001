resource "aws_eks_node_group" "primary" {
  cluster_name    = module.eks.cluster_name
  node_group_name = "${var.project_prefix}-node-group"
  node_role_arn   = module.eks.eks_managed_node_groups["default"].iam_role_arn  # Reference the IAM role output from the EKS module

  subnet_ids = module.vpc.private_subnets  # Reference the private subnets output from the VPC module
  
  scaling_config {
    desired_size = 2
    min_size     = 1
    max_size     = 3
  }

  instance_types = ["t3.medium"]
  capacity_type  = "SPOT"  # Use "ON_DEMAND" if you prefer; SPOT for cost savings
  
  disk_size = 20  # Disk size in GB

  tags = {
    Name        = "${var.project_prefix}-node-group"
    Environment = "dev"
  }
}

resource "aws_iam_role_policy_attachment" "nodes_ebs_policy" {
  policy_arn = aws_iam_policy.ebs_controller_policy.arn
  role       = module.eks.eks_managed_node_groups["default"].iam_role_name
}

resource "aws_iam_policy" "ebs_controller_policy" {
  name = "${var.project_prefix}-ebs-controller-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:CreateVolume",
          "ec2:DeleteVolume",
          "ec2:AttachVolume",
          "ec2:DetachVolume",
          "ec2:DescribeVolumes",
          "ec2:DescribeVolumesModifications",
          "ec2:DescribeInstances",
          "ec2:CreateTags",
          "ec2:DeleteTags"
        ]
        Resource = "*"
      }
    ]
  })
}
