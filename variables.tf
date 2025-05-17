variable "aws_region" {
  description = "Região AWS"
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "Nome do cluster EKS"
  default     = "fastfood-app-eks"
}

variable "cluster_version" {
  description = "Versão do Kubernetes"
  default     = "1.32"
}

variable "db_host" {}
variable "db_name" {}
variable "db_user" {}
variable "db_password" {}
variable "db_port" {
  default = "5432"
}


# Nome do projeto / cluster EKS
variable "projectName" {
  description = "Nome do cluster EKS"
  type        = string
}

# Nome do Node Group
variable "nodeGroup" {
  description = "Nome do node group EKS"
  type        = string
}

# ARN da IAM Role do EKS (geralmente LabRole no AWS Academy)
variable "labRole" {
  description = "ARN da role IAM (ex: LabRole)"
  type        = string
}

# Tipo de instância para o Node Group (ex: t3.small)
variable "instanceType" {
  description = "Tipo da instância EC2"
  type        = string
}

# Região base usada para filtrar AZs (ex: us-east-1)
variable "regionDefault" {
  description = "Região base para ignorar AZ específica (ex: us-east-1)"
  type        = string
}

variable "accessConfig" {
  description = "Modo de autenticação do cluster EKS"
  type        = string
  default     = "API_AND_CONFIG_MAP"
}

variable "policyArn" {
  default = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
}

variable "principalArn" {
  default = "arn:aws:iam::711772164085:role/LabRole"
}
