terraform {
  backend "s3" {
    bucket = "terraform-pipeline-bucket-361598269712"
    key    = "observe/terraform.tfstate"  # ← separado do "infra/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
  }
}
