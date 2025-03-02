variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "eks-cluster-west"
}

variable "project_prefix" {
  description = "Prefix for naming all AWS resources in the project"
  type        = string
  default     = "QC001"
}

variable "cluster_version" {
  description = "Kubernetes version to use for the EKS cluster"
  type        = string
  default     = "1.27"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "environment" {
  description = "Environment name for tagging"
  type        = string
  default     = "training"
}

variable "instance_types" {
  description = "List of EC2 instance types for node group"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "min_size" {
  description = "Minimum number of nodes in node group"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum number of nodes in node group"
  type        = number
  default     = 3
}

variable "desired_size" {
  description = "Desired number of nodes in node group"
  type        = number
  default     = 2
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default = {
    Environment = "training"
    Terraform   = "true"
  }
}

variable "monitoring_namespace" {
  description = "Kubernetes namespace for monitoring tools"
  type        = string
  default     = "monitoring"
}

variable "grafana_storage_size" {
  description = "Storage size for Grafana PVC"
  type        = string
  default     = "10Gi"
}

variable "prometheus_retention_days" {
  description = "Number of days to retain Prometheus data"
  type        = number
  default     = 7
}

variable "node_group_disk_size" {
  description = "Disk size for EKS node group instances in GB"
  type        = number
  default     = 20
}

variable "monitoring_tags" {
  description = "Additional tags for monitoring resources"
  type        = map(string)
  default = {
    Component = "monitoring"
    Tool      = "prometheus-grafana"
  }
}
