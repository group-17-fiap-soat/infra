module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.21.0"

  cluster_name    = var.projectName
  cluster_version = "1.32"
  vpc_id          = aws_vpc.fastfood.id

  subnet_ids = concat(
    aws_subnet.public[*].id,
    aws_subnet.private[*].id
  )

  cluster_endpoint_public_access = true
  manage_aws_auth_configmap      = false

  cluster_enabled_log_types = [
    "api", "audit", "authenticator"
  ]

  cluster_addons = {
    coredns = { resolve_conflicts = "OVERWRITE" }
    kube-proxy = { resolve_conflicts = "OVERWRITE" }
    vpc-cni = { resolve_conflicts = "OVERWRITE" }
  }

  aws_auth_roles = [
    {
      rolearn  = var.principalArn
      username = "admin"
      groups   = ["system:masters"]
    }
  ]

  eks_managed_node_groups = {
    "${var.nodeGroup}" = {
      desired_size   = 2
      min_size       = 1
      max_size       = 2
      instance_types = [var.instanceType]
      key_name       = "devkeypair"
      iam_role_arn   = var.role
    }
  }
}
