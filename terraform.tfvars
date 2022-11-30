
#VPC

ipv4_vpccidr       = "10.0.0.0/20"

pub_subnet = {
pub_snet_1 = {
    pub_az          = "us-east-1a"
    pub_cidr_block  = "10.0.4.0/22"
}
pub_snet_2 = {
    pub_az          = "us-east-1b"
    pub_cidr_block  = "10.0.8.0/22"
}
pub_snet_3 = {
    pub_az          = "us-east-1c"
    pub_cidr_block  = "10.0.12.0/22"
}
}
# pub_az_1                 = "us-east-1a"
#  ipv4_pub_cidr_block1     = "10.0.4.0/22"
# pub_az_2                 = "us-east-1b"
# ipv4_pub_cidr_block2     = "10.0.8.0/22"
# pub_az_3                 = "us-east-1c"
# ipv4_pub_cidr_block3     = "10.0.12.0/22"
# ipv4_pvt_cidr_block4     = "10.0.16.0/22"

##Security Group

sg_details = {
    ec2-sg ={
        name               ="ec2"
        description        = "allow port HTTP & SSH incoming"

        ingress_rules =[
           {
                from_port    = "80"
                to_port      = "80"
                protocol     = "tcp"
                cidr_blocks  = ["0.0.0.0/0"]
                               
            },
            {
                from_port    = "22"
                to_port      = "22"
                protocol     = "tcp"
                cidr_blocks  = ["0.0.0.0/0"]
             
            }

        ]
    }
}

##EC2

ami_id             = "ami-08c40ec9ead489470"  
ec2_type           = "t2.micro" 
ssh_key            = "salman_nv_key"