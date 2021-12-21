variable "vpc_cidr" {
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  default     = "10.0.2.0/24"
}

variable "public_route_cidr_block" {
  default     = "0.0.0.0/0"
}

variable "ingress_cidr" {
  default     = "0.0.0.0/0"
}

variable "egress_cidr" {
  default     = "0.0.0.0/0"
}

variable "ami" {
  default     = "ami-0ed9277fb7eb570c9"
}

variable "instance_type" {
  default     = "t2.micro"
}

variable "key_name" {
  default     = "cicdkops"
}
