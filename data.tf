data "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  depends_on = [aws_vpc.fastfood]
}

data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }
}

data "aws_subnet" "subnet" {
  for_each = local.subnet_id_map
  id       = each.value
}

data "aws_eks_cluster" "eks" {
  name = var.cluster_name
}

data "aws_eks_cluster_auth" "eks" {
  name = var.cluster_name
}