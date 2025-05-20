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



variable "projectName" {
  description = "Nome do cluster EKS"
  type        = string
}

variable "nodeGroup" {
  description = "Nome do node group EKS"
  type        = string
}

variable "role" {
  description = "ARN da role IAM (ex: role)"
  type        = string
}

variable "instanceType" {
  description = "Tipo da instância EC2"
  type        = string
}

variable "regionDefault" {
  description = "Região base para ignorar AZ específica (ex: us-east-1)"
  type        = string
}


variable "principalArn" {
  default = "arn:aws:iam::361598269712:role/RootRole"
}
