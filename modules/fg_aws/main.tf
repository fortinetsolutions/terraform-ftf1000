terraform {
  required_providers {
    aws = "~> 2.0"
    template = "~> 2.1"
  }
}

provider "aws" {
  region = var.region
  shared_credentials_file = var.aws_creds_file
}

#
##Build AWS Resources
#
resource "aws_vpc" "vpc1" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "${var.tag_name_prefix}-vpc1"
  }
}

resource "aws_internet_gateway" "gw1" {
  vpc_id = aws_vpc.vpc1.id
  tags = {
    Name = "${var.tag_name_prefix}-gw1"
  }
}

resource "aws_security_group" "secgrp" {
  name = "${var.tag_name_prefix}-secgrp--any-to-any"
  description = "Security Group - Any to Any"
  vpc_id = aws_vpc.vpc1.id
  ingress {
    description = "Allow all access inbound."
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Allow all access outbound."
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.tag_name_prefix}-secgrp--any-to-any"
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id = aws_vpc.vpc1.id
  cidr_block = var.subnet1_block
  availability_zone = var.availability_zone1
  tags = {
    Name = "${var.tag_name_prefix}-subnet1"
  }
}

resource "aws_route_table" "rt_subnet1" {
  vpc_id = aws_vpc.vpc1.id
  route {
    cidr_block = "0.0.0.0/0"
	  gateway_id = aws_internet_gateway.gw1.id
  }
  tags = {
    Name = "${var.tag_name_prefix}--rt_subnet1"
  }
}

resource "aws_route_table_association" "subnet1" {
  subnet_id = aws_subnet.subnet1.id
  route_table_id = aws_route_table.rt_subnet1.id
}

resource "aws_subnet" "subnet2" {
  vpc_id = aws_vpc.vpc1.id
  cidr_block = var.subnet2_block
  availability_zone = var.availability_zone1
  tags = {
    Name = "${var.tag_name_prefix}-subnet2"
  }
}

resource "aws_route_table" "rt_subnet2" {
  vpc_id = aws_vpc.vpc1.id
  route {
    cidr_block = "0.0.0.0/0"
	  gateway_id = aws_internet_gateway.gw1.id
  }
  tags = {
    Name = "${var.tag_name_prefix}--rt_subnet2"
  }
}

resource "aws_route_table_association" "subnet2" {
  subnet_id = aws_subnet.subnet2.id
  route_table_id = aws_route_table.rt_subnet2.id
}

resource "aws_subnet" "subnet3" {
  vpc_id = aws_vpc.vpc1.id
  cidr_block = var.subnet3_block
  availability_zone = var.availability_zone1
  tags = {
    Name = "${var.tag_name_prefix}-subnet3"
  }
}


#
##Build the FG
#
data "aws_ami" "fortigate_ami" {
  most_recent      = true
  owners           = ["679593333241"]
  filter {
    name   = "name"
    values = ["FortiGate-VM64-AWS *(6.2.*)*"]
  }
}

data "template_file" "fg1_userdata" {
  template = "${file("${path.module}/configs/fg1.tpl")}"
  vars = {
    subnet1_ip_fg1 = var.subnet1_ip_fg1
    subnet1_ip_gw = var.subnet1_ip_gw
    subnet2_ip_gw = var.subnet2_ip_gw
    fg1_license = "${file(var.fg1_license)}"
    sslpassword = var.sslpassword
  }
}

resource "aws_network_interface" "fg1_port1" {
  subnet_id = aws_subnet.subnet1.id
  security_groups = [ "${aws_security_group.secgrp.id}" ]
  private_ips = [ var.subnet1_ip_fg1 ]
  source_dest_check = false
  tags = {
    Name = "${var.tag_name_prefix}-fg1_port1"
  }
}

resource "aws_network_interface" "fg1_port2" {
  subnet_id = aws_subnet.subnet2.id
  security_groups = [ "${aws_security_group.secgrp.id}" ]
  private_ips = [ var.subnet2_ip_fg1 ]
  source_dest_check = false
  tags = {
    Name = "${var.tag_name_prefix}-fg1_port2"
  }
}

resource "aws_network_interface" "fg1_port3" {
  subnet_id = aws_subnet.subnet3.id
  security_groups = [ "${aws_security_group.secgrp.id}" ]
  private_ips = [ var.subnet3_ip_fg1 ]
  source_dest_check = false
  tags = {
    Name = "${var.tag_name_prefix}-fg1_port3"
  }
}

resource "aws_instance" "fg1" {
  ami = data.aws_ami.fortigate_ami.id
  instance_type = var.instance_type
  availability_zone = var.availability_zone1
  key_name = var.aws_key_name
  user_data = data.template_file.fg1_userdata.rendered
  network_interface {
    device_index = 0
    network_interface_id = aws_network_interface.fg1_port1.id
  }
  network_interface {
    device_index = 1
    network_interface_id = aws_network_interface.fg1_port2.id
  }
  network_interface {
    device_index = 2
    network_interface_id = aws_network_interface.fg1_port3.id
  }
  tags = {
	  Name = "${var.tag_name_prefix}-fg1"
  }
}

resource "aws_eip" "fg1_port1" {
  vpc = true
  network_interface = aws_network_interface.fg1_port1.id
  associate_with_private_ip = join(",", aws_network_interface.fg1_port1.private_ips)
  depends_on = [ aws_internet_gateway.gw1 ]
}

resource "aws_eip" "fg1_port2" {
  vpc = true
  network_interface = aws_network_interface.fg1_port2.id
  associate_with_private_ip = join(",", aws_network_interface.fg1_port2.private_ips)
  depends_on = [ aws_internet_gateway.gw1 ]
}

resource "aws_route_table" "rt_subnet3" {
  vpc_id = aws_vpc.vpc1.id
  # route {
  #   cidr_block = "0.0.0.0/0"
  #   gateway_id = aws_network_interface.fg1_port3.id
  # }
  tags = {
    Name = "${var.tag_name_prefix}--rt_subnet3"
  }
}

# resource "aws_route_table_association" "subnet3" {
#   subnet_id = aws_subnet.subnet2.id
#   route_table_id = aws_route_table.rt_subnet3.id
# }