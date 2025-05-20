resource "aws_ecr_repository" "fastfood" {
  name                 = "tech-challenge-fastfood"
  image_tag_mutability = "MUTABLE"

  tags = {
    Name        = "fastfood-ecr"
    Environment = "dev"
  }
}

resource "aws_ecr_lifecycle_policy" "fastfood_policy" {
  repository = aws_ecr_repository.fastfood.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Keep only last 10 untagged images"
        selection = {
          tagStatus   = "untagged"
          countType   = "imageCountMoreThan"
          countNumber = 10
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}
