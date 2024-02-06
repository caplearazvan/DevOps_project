terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "app_server" {
  ami                    = "ami-0faab6bdbac9486fb"
  instance_type          = "t2.micro"
  key_name               = "amazon-key"
  vpc_security_group_ids = ["sg-07be6af9e65dc42e2", "sg-080b3cf708d8bdb28", "sg-0346a684705805e2d"]
  subnet_id              = "subnet-048b7ac9cf0935aca"
  #user_data              = file("script.sh") 

  tags = {
    Name = "App Server"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("amazon-key.pem")
    host        = self.public_ip
  }

  provisioner "file" {
    source      = "ansible/ansible_script.sh"
    destination = "/home/ubuntu/ansible_script.sh"
  }

  provisioner "file" {
    source      = "ansible/playbook.yaml"
    destination = "/home/ubuntu/playbook.yaml"
    }

  provisioner "remote-exec" {
    inline = [
      "echo 'Waiting for user data script to finish'",
      "cloud-init status --wait > /dev/null",
      "chmod +x /home/ubuntu/ansible_script.sh",
      "/home/ubuntu/ansible_script.sh"
    ]
  }
}
resource "aws_instance" "jenkins_server" {
  ami                    = "ami-0faab6bdbac9486fb"
  instance_type          = "t2.micro"
  key_name               = "amazon-key"
  vpc_security_group_ids = ["sg-07be6af9e65dc42e2", "sg-080b3cf708d8bdb28", "sg-0346a684705805e2d"]
  subnet_id              = "subnet-048b7ac9cf0935aca"

  tags = {
    Name = "Jenkins Server"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("amazon-key.pem")
    host        = self.public_ip
  }

  provisioner "file" {
    source      = "jenkins_install.sh"
    destination = "/home/ubuntu/jenkins_install.sh"
  }

  provisioner "file" {
    source      = "ansible/setup_jenkins.yaml"
    destination = "/home/ubuntu/setup_jenkins.yaml"
  }


  provisioner "remote-exec" {
    inline = [
      "cloud-init status --wait > /dev/null",
      "chmod +x /home/ubuntu/jenkins_install.sh",
      "/home/ubuntu/jenkins_install.sh"
    ]
  }
}

resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins_sg"
  description = "Allow inbound ports 22, 8080"
  vpc_id      = "vpc-04fbea77e7ca90096"

  #Allow incoming TCP requests on port 22 from any IP
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  #Allow incoming TCP requests on port 443 from any IP
  ingress {
    description = "Allow HTTPS Traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Allow incoming TCP requests on port 8080 from any IP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Allow all outbound requests
  egress {
    from_port   = 0 # no restriction
    to_port     = 0 # no restriction
    protocol    = "-1" #all protocols
    cidr_blocks = ["0.0.0.0/0"] 
  }
}

resource "aws_security_group" "app_sg" {
  name        = "application security group"
  description = "Allow inbound ports 22, 443, 80"
  vpc_id      = "vpc-04fbea77e7ca90096"

  #Allow incoming TCP requests on port 22 from any IP
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Allow incoming TCP requests on port 443 from any IP
  ingress {
    description     = "Allow HTTPS Traffic"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
  }

  #Allow incoming TCP requests on port 8080 from any IP
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}

  #Allow all outbound requests
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}