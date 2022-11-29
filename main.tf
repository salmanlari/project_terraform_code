provider "aws" {
    region = "us-east-1"
    
} 

# NETWORK

module "nw" {
source = "./module/nw"
vpccidr = "10.0.0.0/16"
pub_subnet = {
  pub_snet_1 = {
    pub_az = "us-east-1a"
    pub_cidr_block = "10.0.1.0/24"
  }
 pub_snet_2 = {
    pub_az = "us-east-1b"
    pub_cidr_block = "10.0.2.0/24"
  }
   pub_snet_3 = {
    pub_az = "us-east-1c"
    pub_cidr_block = "10.0.3.0/24"
}
}
pvt_cidr_block = "10.0.4.0/24"

}

# ec2 security group

module "sg" {
    source = "./module/sg"
    sg_details = {
    ec2-sg ={
        name            ="ec2"
        description     = "all incoming"
        vpc_id          = module.nw.aws_vpc_output_id
        ingress_rules =[
           {
                from_port   = "80"
                to_port     = "80"
                protocol    = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
                self        = null                
            },
            {
                from_port    = "22"
                to_port      = "22"
                protocol     = "tcp"
                cidr_blocks  = ["0.0.0.0/0"]
                self         = null
            },

        ]
    }
    }

}

#EC2 

module "ec2" {
    source             = "./module/ec2"
    ami_id             = "ami-08c40ec9ead489470"  
    ec2_type           = "t2.micro" 
    ssh_key            = "salman_nv_key"
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