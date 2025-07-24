# data "aws_eks_cluster" "eks" {
#   name = "fastfood-app-eks"
# }
#
# data "aws_eks_cluster_auth" "eks" {
#   name = "fastfood-app-eks"
# }
#
# provider "kubernetes" {
#   host                   = data.aws_eks_cluster.eks.endpoint
#   cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
#   token                  = data.aws_eks_cluster_auth.eks.token
# }
#
# resource "kubernetes_config_map" "aws_auth" {
#   metadata {
#     name      = "aws-auth"
#     namespace = "kube-system"
#   }
#
#   data = {
#     mapRoles = yamlencode([
#       {
#         rolearn  = "arn:aws:iam::361598269712:role/RootRole"
#         username = "admin"
#         groups   = ["system:masters"]
#       }
#     ])
#   }
#
#   lifecycle {
#     ignore_changes = [metadata]
#     replace_triggered_by = [data.aws_eks_cluster.eks.id]
#   }
#
# }