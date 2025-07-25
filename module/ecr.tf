# ECR: Order Service
resource "aws_ecr_repository" "order" {
  name                 = "order-fastfood"
  image_tag_mutability = "MUTABLE"

  tags = {
    Name        = "order-fastfood-ecr"
    Environment = "dev"
  }
}

resource "aws_ecr_lifecycle_policy" "order_policy" {
  repository = aws_ecr_repository.order.name

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

# ECR: Payment Service
resource "aws_ecr_repository" "payment" {
  name                 = "payment-fastfood"
  image_tag_mutability = "MUTABLE"

  tags = {
    Name        = "payment-fastfood-ecr"
    Environment = "dev"
  }
}

resource "aws_ecr_lifecycle_policy" "payment_policy" {
  repository = aws_ecr_repository.payment.name

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

# ECR: Auth Service
resource "aws_ecr_repository" "auth" {
  name                 = "auth-fastfood"
  image_tag_mutability = "MUTABLE"

  tags = {
    Name        = "auth-fastfood-ecr"
    Environment = "dev"
  }
}

resource "aws_ecr_lifecycle_policy" "auth_policy" {
  repository = aws_ecr_repository.auth.name

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
