

#key pair
resource "aws_key_pair" "my-key" {
  key_name   = "terra-key"
  public_key = file("my-variable-ec2-key.pub")
}

#vpc
resource "aws_default_vpc" "my-vpc" {
}

#security group
resource "aws_security_group" "my-security" {
  name        = "my-sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_default_vpc.my-vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "to allows all ssh port to open"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "to allows all HTTP port to open"
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "HTTP"
    cidr_blocks = ["0.0.0.0/0"]
    description = "to allows all HTTP port to open"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    Name = "my-ec2-sg"
  }
}


# ec2 instance
resource "aws_instance" "my-instance" {
  key_name        = aws_key_pair.my-key.key_name
  security_groups = [aws_security_group.my-security.name]
  instance_type   = var.instance_type
  ami             = var.ami_id
  root_block_device {
    volume_size = var.volume_size
    volume_type = var.volume_type
  }
  tags = {
    name = "aws_first_ec2"
  }
}

