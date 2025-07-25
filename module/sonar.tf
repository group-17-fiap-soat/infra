resource "aws_instance" "sonar" {
  ami           = var.sonar_ami_id
  instance_type = var.sonar_instance_type
  key_name      = var.sonar_key_name

  vpc_security_group_ids = [aws_security_group.sg.id]
  subnet_id              = aws_subnet.public[0].id

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras enable docker
              yum install -y docker
              systemctl start docker
              systemctl enable docker
              usermod -aG docker ec2-user

              curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
              chmod +x /usr/local/bin/docker-compose

              mkdir -p /opt/sonarqube
              cat <<EOL > /opt/sonarqube/docker-compose.yml
              version: "3"
              services:
                sonarqube:
                  image: sonarqube:community
                  container_name: sonarqube
                  ports:
                    - "9000:9000"
                  environment:
                    - SONAR_ES_BOOTSTRAP_CHECKS_DISABLE=true
                  volumes:
                    - sonarqube_data:/opt/sonarqube/data
                    - sonarqube_extensions:/opt/sonarqube/extensions
                  restart: unless-stopped

              volumes:
                sonarqube_data:
                sonarqube_extensions:
              EOL

              cd /opt/sonarqube
              docker-compose up -d
              EOF
  tags = {
    Name = "fastfood-sonar"
  }
}
