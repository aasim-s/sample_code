# Create an internet gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = var.VPC_ID
  tags = {
    Name = "my-igw"
  }
}

# Create a route table
resource "aws_route_table" "my_route_table" {
  vpc_id = var.VPC_ID

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = "my-route-table"
  }
}

# Associate the subnet with the route table
resource "aws_route_table_association" "my_association" {
  subnet_id      = var.SUBNET_ID
  route_table_id = aws_route_table.my_route_table.id
}