resorce "aws_key_pair" "security-key" {
	key_name = "sample-key"
	public_key = file("dove-key.pub")
}


resource "aws_security_group" "sample-sg" {
	name = "sample-sg"
	description = "Sample security group"
	#vpc_id = "give vpc id"

	ingress {
		from_port = 22
		to_port = 22
		protocol = "tcp"
		cidr_blocks = [var.MY_IP]
	}

	ingress {
		from_port = 80
		to_port = 80
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	Egress {
		from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}
}

resource "aws_instance" "my-instance" {
	ami = var.AMI[var.REGION]
	#vpc_id = "give vpc id"
	availability_zone = var.ZONE[1]
	instance_type = var.TYPE[1]
	key_name = aws_key_pair.security-key.key_name
	vpc_security_group_ids = [aws_security_group.sample-sg.id]
	tags = {
		Name = "my-instance"
		Project = "sample"
	}

	provisioner "file" {
		source = "web.sh"
		destination = "/tmp/web.sh"
	}

	provisioner "remote-exec" {
		inline = [
			"chmond u+x /tmp/web.sh",
			"sudo sh /tmp/web.sh"
		]
	}

	connection {
		user = var.USER
		private_key = file("dove-key")
		host = self.public_ip
	}
}

output "instance-public-ip" {
	value = aws_instance.my-instance.public_ip
}

output "instance-private-ip" {
	value = aws_instance.my-instance.private_ip
}

# can link an instance with a security group with below code

# resource "aws_network_interface_sg_attachment" "sg_attachment" {
#    security_group_id    = aws_security_group.sample-sg.id
#    network_interface_id = aws_instance.my-instance.primary_network_interface_id
# }