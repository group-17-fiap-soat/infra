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

variable "vpc_id" {
  description = "ID do VPC"
  default     = "vpc-020662cd542571ff7"
}

variable "subnet_ids" {
  description = "Lista de subnets para o cluster"
  type        = list(string)
  default     = [
    "subnet-084da95071102eca6",
    "subnet-04e976fc1d97d1e3d",
    "subnet-00b697423fccfcacb",
    "subnet-0c8d2426cf35a438a"
  ]
}

variable "instance_type" {
  description = "Tipo da instância EC2"
  default     = "t3a.small"
}

variable "key_name" {
  description = "Nome do par de chaves EC2"
  default     = "devkeypair"
}

variable "image_url" {
  description = "Imagem Docker no ECR"
  default     = "711772164085.dkr.ecr.us-east-1.amazonaws.com/tech-challenge-fastfood:latest"
}

variable "ingress_host" {
  description = "Host do Ingress para a aplicação"
  default     = "springboot.local.com"
}

variable "kubeconfig_path"{
  default = "~/.kube/config"
  description = "path de configuração do kubernets"
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

variable principalArn {
  default = "arn:aws:iam::711772164085:role/LabRole"
}
