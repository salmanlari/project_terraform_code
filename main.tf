provider "aws" {
    region = "us-east-1"
    
} 

# NETWORK

module "nw" {
source = "./module/nw"
vpccidr = var.ipv4_vpccidr
pub_subnet = var.pub_subnet
#   pub_snet_1 = {
# #     pub_az = var.pub_az_1
# #     pub_cidr_block = var.ipv4_pub_cidr_block1
# #   }
# #  pub_snet_2 = {
# #     pub_az = var.pub_az_2
# #     pub_cidr_block = var.ipv4_pub_cidr_block2
# #   }
# #    pub_snet_3 = {
# #     pub_az = var.pub_az_3
# #     pub_cidr_block = var.ipv4_pub_cidr_block3
# # }
# }
# pvt_cidr_block = var.ipv4_pvt_cidr_block4

}

# # ec2 security group

module "sg" {
    source = "./module/sg"
    vpc_id                   = module.nw.aws_vpc_output_id
    sg_details               = var.sg_details

}

# #EC2 

module "ec2" {
    source             = "./module/ec2"
    ami_id             = var.ami_id 
    ec2_type           = var.ec2_type 
    ssh_key            = var.ssh_key
    subnet1 ={                                                               
        snet_1={
            subnet = lookup(module.nw.pub_snet_output_id,"pub_snet_1",null).id  
            name = "Server-1"
        },
        
        snet_2={
                subnet = lookup(module.nw.pub_snet_output_id,"pub_snet_2",null).id 
                name = "server-2"
     
            },

        snet_3={
                subnet = lookup(module.nw.pub_snet_output_id,"pub_snet_3",null).id 
                name = "server-3"
            }    

    }
     sg = lookup(module.sg.sg_output_id, "ec2-sg", null)

}