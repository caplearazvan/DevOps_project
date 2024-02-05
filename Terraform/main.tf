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
    type = "ssh"
    user        = "ubuntu"
    private_key = file("./amazon-key.pem")
    host = self.public_ip
  }
   provisioner "file" {
    source      = "./ansible/playbook.yaml"
    destination = "/home/ubuntu/playbook.yaml"
  }
  provisioner "file" {
    source      = "./ansible/ansible_script.sh"
    destination = "/home/ubuntu/ansible_script.sh"
  }
  # execute on the EC2-instance .sh file
  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/ansible_script.sh",
      "/home/ubuntu/ansible_script.sh",
    ]
  }
}
# resource "aws_instance" "jenkins_server" {
#   ami                    = "ami-0faab6bdbac9486fb"
#   instance_type          = "t2.micro"
#   key_name               = "amazon-key"
#   vpc_security_group_ids = ["sg-07be6af9e65dc42e2", "sg-080b3cf708d8bdb28", "sg-0346a684705805e2d"]
#   subnet_id              = "subnet-048b7ac9cf0935aca"
#   user_data              = file("script.sh") 

#   tags = {
#     Name = "Jenkins Server"
#   }
# }