provider "aws" {
  region = "ap-south-1"
}


module "my_vpc" {
  source = "../vpc"
}


module "my_gateway" {
  source    = "../gateways"
  SUBNET_ID = module.my_vpc.my-subnet-id
  VPC_ID    = module.my_vpc.my-vpc-id
}

module "my_instance" {
  source    = "../instance"
  SUBNET_ID = module.my_vpc.my-subnet-id
  VPC_ID    = module.my_vpc.my-vpc-id
  MY_IP     = "125.21.225.166/32"
  FILE_NAME = "web.sh"
}