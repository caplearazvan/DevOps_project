provider "aws" {
  region = "eu-central-1"
}
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
    ami           = data.aws_ami.ubuntu.id
    instance_type = "t3.micro"
    key_name               = "amazon-key"
    vpc_security_group_ids = ["sg-07be6af9e65dc42e2", "sg-080b3cf708d8bdb28", "sg-0346a684705805e2d"]
    subnet_id              = "subnet-048b7ac9cf0935aca"

    tags = {
        Name = "App Server"
    }

    connection {
        type     = "ssh"
        user     = "ubuntu"
        private_key = file("amazon-key.pem")
        host     = self.public_ip
    }

    provisioner "file" {
        source = "ansible/ansible_script.sh"
        destination = "/home/ubuntu/ansible_script.sh"
    }

    provisioner "file" {
        source = "ansible/playbook.yaml"
        destination = "/home/ubuntu/playbook.yaml"
    }

    provisioner "remote-exec" {  
    inline = [  
    "echo 'Waiting for user data script to finish'",  
    "cloud-init status --wait > /dev/null"  
    ]  
}   
    # provisioner "local-exec" {
    #     command = "sleep 300"
    # }
    provisioner "remote-exec" {
        inline = [
            "chmod +x /home/ubuntu/ansible_script.sh",
            "/home/ubuntu/ansible_script.sh"
        ]
    }
}

# resource "aws_instance" "jenkins_server" {
#   ami                    = "ami-0faab6bdbac9486fb"
#   instance_type          = "t2.micro"
#   key_name               = "amazon-key"
#   vpc_security_group_ids = ["sg-07be6af9e65dc42e2", "sg-080b3cf708d8bdb28", "sg-0346a684705805e2d"]
#   subnet_id              = "subnet-048b7ac9cf0935aca"
# #   user_data              = file("script.sh") 

#   tags = {
#     Name = "Jenkins Server"
#   }
# }