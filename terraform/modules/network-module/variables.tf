variable "region" {
  type        = string
  default     = "eu-west-1"
  description = "AWS Region"
}

variable "env_name" {
  type        = string
  default     = "prod"
}

variable "VPC_CIDR" {
  type        = string
  default     = "10.10.0.0/16"
  description = "VPC CIDR range"
}

variable "subnet_cidr_block" {
  type= string
  default = "10.10.1.0/24"
  
}
variable "public_subnets_names" {
  type    = list(string)
  default = ["pub-sub-prod-01", "pub-sub-prod-02"]
}

variable "public_subnets_cidr" {
  type=list(string)
  default = [ "10.10.1.0/24", "10.10.2.0/24" ]

}

variable "private_subnets_names" {
  type    = list(string)
  default = ["private-sub-prod-01", "private-sub-prod-02"]
}

variable "private_subnets_cidr" {
  type=list(string)
  default = [ "10.10.3.0/24", "10.10.4.0/24" ]

}
variable "subnet_azs" {
  type=list(string)
  default = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  
}