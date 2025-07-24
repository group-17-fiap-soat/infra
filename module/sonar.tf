resource "aws_security_group" "sonar" {
  name        = "fastfood-sonar-sg"
  description = "Allow inbound traffic to SonarQube"
  vpc_id      = aws_vpc.fastfood.id

  ingress {
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "fastfood-sonar-sg"
  }
}

resource "aws_instance" "sonar" {
  ami           = var.sonar_ami_id
  instance_type = var.sonar_instance_type
  key_name      = var.sonar_key_name

  vpc_security_group_ids = [aws_security_group.sonar.id]
  subnet_id              = aws_subnet.public[0].id

  tags = {
    Name = "fastfood-sonar"
  }
}
