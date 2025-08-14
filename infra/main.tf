resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project_name}-vpc"
    Env  = var.env
  }
}

# Internet Gateway (for public subnets)
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.project_name}-igw"
    Env  = var.env
  }
}

# ---------------------------
# Public subnets (count = 3)
# ---------------------------
resource "aws_subnet" "pub_sub" {
  count                   = var.pub_sub_count
  vpc_id                  = aws_vpc.main.id
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, local.subnet_mask_increase, count.index + 1)
  map_public_ip_on_launch = true

  tags = {
    Name                                         = "${var.env}-pub-sub-${count.index + 1}"
    Env                                          = var.env
    "kubernetes.io/cluster/${local.cluster_tag}" = "shared"
    "kubernetes.io/role/elb"                     = "1"
  }
}

# Public route table + default route via IGW
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.project_name}-public-rt"
    Env  = var.env
  }
}

# Associate public subnets to public RT
resource "aws_route_table_association" "public" {
  count          = var.pub_sub_count
  subnet_id      = aws_subnet.pub_sub[count.index].id
  route_table_id = aws_route_table.public.id
}

# ----------------------------
# Private subnets (count = 3)
# ----------------------------
resource "aws_subnet" "pr_sub" {
  count             = var.pr_sub_count
  vpc_id            = aws_vpc.main.id
  availability_zone = data.aws_availability_zones.available.names[count.index]

  # Offset private ranges after public ranges
  cidr_block = cidrsubnet(
    aws_vpc.main.cidr_block,
    local.subnet_mask_increase,
    count.index + var.pub_sub_count + 1
  )

  tags = {
    Name                                         = "${var.env}-pr-sub-${count.index + 1}"
    Env                                          = var.env
    "kubernetes.io/cluster/${local.cluster_tag}" = "shared"
    "kubernetes.io/role/internal-elb"            = "1"
  }
}

# Private route table (no 0.0.0.0/0 => isolated)
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.project_name}-private-rt"
    Env  = var.env
  }
}

# Associate private subnets to private RT
resource "aws_route_table_association" "private" {
  count          = var.pr_sub_count
  subnet_id      = aws_subnet.pr_sub[count.index].id
  route_table_id = aws_route_table.private.id
}