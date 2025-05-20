data "aws_eks_cluster" "eks" {
  name = "fastfood-app-eks"
}

data "aws_eks_cluster_auth" "eks" {
  name = "fastfood-app-eks"
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.eks.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.eks.token
}