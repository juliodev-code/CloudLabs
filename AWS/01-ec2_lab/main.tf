#this resource let's you create the private network for provide IPs
#VPC = Closed city
resource "aws_vpc" "this" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "terraform-ec2-lab-vpc"
  }
}

#we reserved 256 IPs in this subnet to public ec2 instances
#Subnet = Colony
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "${var.aws_region}a"

  tags = {
    Name = "public-subnet"
  }
}

#we put the vpc created to internet access
#Internet Gateway = Main door
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
}

#route table redirects the traffic to a certain point, in this case to internet
#Route Table = Calle que conecta a la puerta
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }
}

#this indicates which traffic of an specific subnet
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

#this is a firewall for a certain instance for allow ssh connection
resource "aws_security_group" "ssh" {
  name   = "allow-ssh"
  vpc_id = aws_vpc.this.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # ⚠️ For learning only
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#we create the ec2 instance with all resources created
# EC2 = Casa
resource "aws_instance" "this" {
  ami                    = "ami-0c02fb55956c7d316" # Amazon Linux 2 (us-east-1)
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.ssh.id]
  key_name               = var.key_name

  tags = {
    Name = "terraform-ec2-lab"
  }
}

