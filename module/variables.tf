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


variable "s3_bucket_name" {
  default = "terraform-pipeline-bucket-361598269712"
}


variable "principalArn" {
  default = "arn:aws:iam::361598269712:role/RootRole"
}

variable "sonar_ami_id" {
  description = "AMI ID for the SonarQube instance"
  type        = string
  default     = "ami-0c55b159cbfafe1f0" # Bitnami SonarQube CE
}

variable "sonar_instance_type" {
  description = "Instance type for the SonarQube instance"
  type        = string
  default     = "t3.medium"
}

variable "sonar_key_name" {
  description = "Key pair name for the SonarQube instance"
  type        = string
  default     = "fastfood"
}
