resource "aws_vpc" "my-vpc" {
	cidr_block = "10.0.0.0/16"
	enable_dns_support = true
	enable_dns_hostnames = true
	tags = {
		Name = "my-vpc"
		Project = "sample"
	}
}

resource "aws_subnet" "public_subnet" {
	vpc_id = aws_vpc.my-vpc.id
	cidr_block = "10.0.1.0/24"
	availability_zone = var.ZONE[1]
	map_public_ip_on_launch = true
# map_public_ip_on_launch attribute in the public subnets ensures that 
# instances launched in those subnets will have public IP addresses by default.
	tags = {
		Name = "public-subnet"
	}
}

resource "aws_subnet" "private_subnet" {
	vpc_id = aws_vpc.my-vpc.id
	cidr_block = "10.0.2.0/24"
	availability_zone = var.ZONE[2]
	tags = {
		Name = "private-subnet"
	}
}

output "my-subnet-id" {
	value = aws_subnet.public_subnet.id
}

output "my-vpc-id" {
	value = aws_vpc.my-vpc.id
}
