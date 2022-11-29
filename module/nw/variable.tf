variable "vpccidr" {
  
}

variable "pvt_cidr_block" {
  
}

variable "pub_subnet" {
  type             = map(object({
   pub_cidr_block  =  string
    pub_az         = string

  })) 
}
