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
  default     = "ami-0abcdef1234567890" # Placeholder - Replace with a valid SonarQube AMI for your region
}

variable "sonar_instance_type" {
  description = "Instance type for the SonarQube instance"
  type        = string
  default     = "t3.micro"
}

variable "sonar_key_name" {
  description = "Key pair name for the SonarQube instance"
  type        = string
  default     = "fastfood"
}
