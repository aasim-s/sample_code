variable "REGION" {
  default = "ap-south-1"
}

variable "ZONE" {
  type = map(any)
  default = {
    1 = "ap-south-1a"
    2 = ""
    3 = ""
  }
}

variable "AMI" {
  type = map(any)
  default = {
    ap-south-1 = "ami-067c21fb1979f0b27"
    region2 = ""
    region3 = ""
  }
}

variable "TYPE" {
  type = map(any)
  default = {
    1 = "t2.micro"
    2 = ""
    3 = ""
  }
}

variable "USER" {
  default = "ec2-user"
}

variable "MY_IP" {}
variable "SUBNET_ID" {}
variable "VPC_ID" {}
variable "FILE_NAME" {}