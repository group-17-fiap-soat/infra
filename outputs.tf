#####################################
#        ECR Repository Outputs     #
#####################################
output "ecr_repository_name" {
  value       = aws_ecr_repository.fastfood.name
  description = "ECR repository name"
}

output "ecr_repository_url" {
  value       = aws_ecr_repository.fastfood.repository_url
  description = "URL to push/pull Docker images"
}

output "ecr_repository_arn" {
  value       = aws_ecr_repository.fastfood.arn
  description = "ECR repository ARN"
}

#####################################
#        EKS Cluster Outputs        #
#####################################
output "eks_cluster_name" {
  value       = aws_eks_cluster.eks_cluster.name
  description = "Name of the EKS cluster"
}

output "eks_cluster_endpoint" {
  value       = aws_eks_cluster.eks_cluster.endpoint
  description = "EKS cluster endpoint"
}

output "eks_cluster_ca" {
  value       = aws_eks_cluster.eks_cluster.certificate_authority[0].data
  description = "Base64 encoded EKS certificate authority data"
}

output "eks_cluster_arn" {
  value       = aws_eks_cluster.eks_cluster.arn
  description = "ARN of the EKS cluster"
}

output "eks_node_group_name" {
  value       = aws_eks_node_group.eks_node.node_group_name
  description = "Name of the EKS managed node group"
}

#####################################
#         Lambda Outputs            #
#####################################
output "lambda_function_name" {
  value       = aws_lambda_function.check_user_email.function_name
  description = "Lambda function name"
}

output "lambda_function_arn" {
  value       = aws_lambda_function.check_user_email.arn
  description = "Lambda function ARN"
}

# Removido o output "lambda_function_url" pois não está definido nenhum recurso aws_lambda_function_url no Terraform

#####################################
#         Networking Outputs        #
#####################################
output "vpc_id" {
  value       = aws_vpc.fastfood.id
  description = "VPC ID"
}

output "public_subnet_ids" {
  value       = aws_subnet.public[*].id
  description = "List of public subnet IDs"
}

output "private_subnet_ids" {
  value       = aws_subnet.private[*].id
  description = "List of private subnet IDs"
}

output "security_group_id" {
  value       = aws_security_group.sg.id
  description = "Security group ID used by cluster"
}

#####################################
#         API Gateway Outputs       #
#####################################
output "api_gateway_url" {
  value       = aws_apigatewayv2_api.auth.api_endpoint
  description = "API Gateway public endpoint URL"
}
