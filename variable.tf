
#Network Variable

variable "ipv4_vpccidr" {
   description     = "CIDR block for vpc"
   type            = string
}

variable "pub_subnet" {
  description       = "public subnet range"
  type              = map(object({
  pub_cidr_block    = string
  pub_az            = string

  })) 
}
# variable "pub_az_1" {
   
#     type = string
# }
# variable "ipv4_pub_cidr_block1" {

#     type = string
# }
# variable "pub_az_2" {
#     type = string
# }
# variable "ipv4_pub_cidr_block2" {
#     type = string
# }
# variable "pub_az_3" {
#     type = string
# }
# variable "ipv4_pub_cidr_block3" {
#     type = string
# }
# variable "ipv4_pvt_cidr_block4" {}



### Security Group variable
variable "sg_details" {
    type          = map(object({
    name          = string
    description   = string

    ingress_rules = list(object({
    from_port     = number
    to_port       = number
    protocol      = string
    cidr_blocks   = list(string)


    }))
}))

}

# #ec2 variable

variable "ami_id" {
  description    = "EC2 instance AMI ID"
  type           = string
    validation {
    condition = (
        length(var.ami_id) > 6 &&
        substr(var.ami_id, 0, 4) == "ami-"
    )
    error_message = "The ami_id value must start with \"ami-\"."
    }


}
variable "ec2_type" {
  description    = "EC2 instance type"
  type           = string
  }

variable "ssh_key" {
  description    = "EC2 instance ssh key"
  type           = string
}
