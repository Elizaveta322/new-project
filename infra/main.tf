module "vpc" {
  source        = "./vpc"
  env           = var.env
  cluster_name  = var.cluster_name
  vpc_cidr      = var.vpc_cidr
  project_name  = var.project_name
  pub_sub_count = var.pub_sub_count
  pr_sub_count  = var.pr_sub_count
}