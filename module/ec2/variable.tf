variable "ami_id" {
}

variable "ec2_type" {  
}

variable "sg" {
}


variable "subnet1" {
     type    = map(object({
     subnet  = string
     name    = string
    })) 
}

variable "ssh_key" {
     
}