resource "aws_instance" "app-test" {
ami                     = var.ami_id
instance_type           = var.instance_type
key_name                = var.key_name
vpc_security_group_ids  = [aws_security_group.my_sg.id]
subnet_id               = aws_subnet.publicsubnet-1.id


  tags =  {
    Name = "app-test"
     Environment = "training"
}
}

resource "aws_instance" "lb-test" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.lb_sg.id]
  subnet_id              = aws_subnet.publicsubnet-2.id

  tags = {
    Name = "dev-lb"
  }
}

resource "aws_security_group" "my_sg" {
  vpc_id      =  aws_vpc.test_vpc.id
  name = "test_my-sg"
    description = "security group that allows ssh and all egress traffic"
   egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
   ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["49.204.239.163/32"]
  }
   ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    security_groups = [aws_security_group.lb_sg.id]
  }
    ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.lb_sg.id]
  }
  tags = {
    Name = "my-sg_name"
  }
}


resource "aws_security_group" "lb_sg" {
  vpc_id      =  aws_vpc.test_vpc.id
  name = "test-lb_sg"
  description = "security group that allows ssh and all egress traffic"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["49.204.239.163/32"]
  }

   ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
   ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "lb_sg"
  }
}
