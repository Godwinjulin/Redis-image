resource "aws_instance" "jenkins-server" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.jenkins-server.key_name
  subnet_id              = aws_subnet.main-public.id
  vpc_security_group_ids = [aws_security_group.allow_ssh_jenkins.id]
  user_data_base64       = data.cloudinit_config.userdata.rendered

  lifecycle {
    ignore_changes = [ami, user_data_base64]
  }

  tags = merge(local.common_tags, { Name = "jenkins-server", Company = "EliteSolutionsIT" })
}

///key
resource "aws_key_pair" "jenkins-server" {
  key_name   = "jenkins-server"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQClvlKapWyb3EeaH8zIzWwM/mQr22SWzggpiKzaMJkDwQLquTjv1iPy5ykSMl3BN23M9K19EaCDFVlfe7Fx7bzB/HHryo4rC3YZ95vX2nsMTOcyELQAX/K3KCLQlv26ii1pleRHs65mUCv9NYZsXOt9XyfSJG9p0plSLtb7sqM3fbOF0PbbkOPvyE+pBB6bQ/nq83xHehOdcsF4bMrWMmioMeDXhRdjvU9RtKQnRm7dUvSR/Dq+EEP+qVTJPAUN4MDvpg3ymHxQ5p490FVycxD9WRpFhwSt/NeI2bT8ArW3jJOCf6K6VjALXPrEXaUh8yQ2/fm7+4WPS4yKHWH6/HhCjsd6Vz/ipvSg/W0KcrQfBLynIfZf9GLlPmY+9SubQEzPaRe6tNGws9tZYtzw6cTMAg/quF8SCl1YpstbV5WdAKxjaFMUBQnIUoqJmApKygz0BPt7hFMOFHngSRwEm0zPnuA34jm1roqw+9zsyW0uc82twMaBNg2pvK8+gv0xjEc= lbena@LAPTOP-QB0DU4OG"
}

///jenkins sg
resource "aws_security_group" "allow_ssh_jenkins" {
  name        = join("-", [local.network.Environment, "allow_ssh_jenkins"])
  description = "Allow ssh and jenkins inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["70.114.65.185/32"]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["70.114.65.185/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(local.common_tags, { Name = "securitygrp-jenkins", Company = "EliteSolutionsIT" })

}