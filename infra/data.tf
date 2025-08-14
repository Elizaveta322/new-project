data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  # From /16 to /24 (adjust to your scheme)
  subnet_mask_increase = 8
  # Tag used by AWS Load Balancer Controller discovery
  cluster_tag = "${var.cluster_name}-${var.env}"
}