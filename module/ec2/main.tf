resource "aws_instance" "ec2" {  
  for_each           = var.subnet1
  ami                = var.ami_id
  instance_type      = var.ec2_type
  subnet_id          = each.value ["subnet"]
  security_groups    = [var.sg]
  key_name           = var.ssh_key
user_data = <<-EOF
    #!/bin/bash
    sudo apt update -y
    sudo apt install nginx -y
    sudo apt install docker.io -y
    sudo usermod -a -G docker ubuntu
    hostnamectl set-hostname ${each.value["name"]}

EOF
  tags = {  
     Name = "${each.value["name"]}"
  
  } 
}

#generate ec2 key

resource "aws_key_pair" "ec2_key" {
  key_name   = "ec2_key"
  public_key = tls_private_key.ec2_rsa.public_key_openssh
  }
  resource "tls_private_key" "ec2_rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "ec2_key" {
    content  = tls_private_key.ec2_rsa.private_key_pem
    filename = "terraform_key"
}