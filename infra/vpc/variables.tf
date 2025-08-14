# variables.tf
variable "env" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
}

variable "project_name" {
  description = "Project name prefix for tagging"
  type        = string
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "pub_sub_count" {
  description = "Number of public subnets"
  type        = number
  default     = 3
}

variable "pr_sub_count" {
  description = "Number of private subnets"
  type        = number
  default     = 3
}