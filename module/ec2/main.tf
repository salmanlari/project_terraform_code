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
    hostnamectl set-hostname ${each.value["name"]}
EOF
  tags = {  
     Name = "${each.value["name"]}"
  
  }
  
}