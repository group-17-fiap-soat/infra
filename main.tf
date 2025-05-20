module "infra" {
  source = "./module"

  aws_region      = var.aws_region
  regionDefault   = var.regionDefault
  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  projectName     = var.projectName
  nodeGroup       = var.nodeGroup
  role            = var.role
  instanceType    = var.instanceType
  s3_bucket_name  = var.s3_bucket_name
}