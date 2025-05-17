resource "aws_security_group" "sg" {
  name        = "SG-allow-all"
  description = "Usado no EKS com 6/7SOAT"
  vpc_id      = aws_vpc.fastfood.id

  # Inbound
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound
  egress {
    description = "All"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "sg_postgres" {
  name        = "SG-postgres"
  description = "Permite acesso ao PostgreSQL (porta 5432)"
  vpc_id      = aws_vpc.fastfood.id

  ingress {
    description = "PostgreSQL"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "PostgreSQL"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-postgres"
  }
}