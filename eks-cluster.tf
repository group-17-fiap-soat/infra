#
# resource "aws_eks_cluster" "eks_cluster" {
#   name     = var.projectName
#   role_arn = var.role
#
#   vpc_config {
#     subnet_ids         = [for subnet in data.aws_subnet.subnet : subnet.id if subnet.availability_zone != "${var.aws_region}e"]
#     security_group_ids = [aws_security_group.sg.id]
#   }
#
#   access_config {
#     authentication_mode = var.accessConfig
#   }
# }

#
# resource "aws_eks_node_group" "eks_node" {
#   cluster_name    = aws_eks_cluster.eks_cluster.name
#   node_group_name = var.nodeGroup
#   node_role_arn   = var.role
#   subnet_ids      = [for subnet in data.aws_subnet.subnet : subnet.id if subnet.availability_zone != "${var.aws_region}e"]
#   disk_size       = 50
#   instance_types  = [var.instanceType]
#
#   scaling_config {
#     desired_size = 2
#     min_size     = 1
#     max_size     = 2
#   }
#
#   update_config {
#     max_unavailable = 1
#   }
# }

resource "terraform_data" "eks_ready" {
  depends_on = [module.eks]
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.21.0"


  cluster_name    = var.projectName
  cluster_version = "1.32"
  vpc_id          = aws_vpc.fastfood.id
  subnet_ids      = [for subnet in data.aws_subnet.subnet : subnet.id if subnet.availability_zone != "${var.aws_region}e"]

  cluster_endpoint_public_access = true
  manage_aws_auth_configmap      = true


  cluster_enabled_log_types = [
    "api",
    "audit",
    "authenticator"
  ]

  cluster_addons = {
    coredns = {
      resolve_conflicts = "OVERWRITE"
    }
    kube-proxy = {
      resolve_conflicts = "OVERWRITE"
    }
    vpc-cni = {
      resolve_conflicts = "OVERWRITE"
    }
  }

  aws_auth_roles = [
    {
      rolearn  = var.principalArn
      username = "admin"
      groups   = ["system:masters"]
    }
  ]

  eks_managed_node_groups = {
    fastfood-node = {
      desired_size   = 2
      min_size       = 1
      max_size       = 2
      instance_types = [var.instanceType]
      key_name       = "devkeypair"
      iam_role_arn   = var.role
    }
  }
}
