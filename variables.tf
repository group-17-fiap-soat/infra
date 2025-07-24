variable "aws_region" {}
variable "regionDefault" {}
variable "cluster_name" {}
variable "cluster_version" {}
variable "projectName" {}
variable "nodeGroup" {}
variable "role" {}
variable "instanceType" {}
variable "s3_bucket_name" {}

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
