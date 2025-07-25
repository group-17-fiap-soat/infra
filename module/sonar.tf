resource "aws_instance" "sonar" {
  ami           = var.sonar_ami_id
  instance_type = var.sonar_instance_type
  key_name      = var.sonar_key_name

  vpc_security_group_ids = [aws_security_group.sg.id]
  subnet_id              = aws_subnet.public[0].id

  tags = {
    Name = "fastfood-sonar"
  }
}
