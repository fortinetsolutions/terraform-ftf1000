variable "aws_creds_file" {
  description = "AWS credentials file."
  default = "$HOME/.aws/credentials"
}
variable "region" { 
  default = "us-east-2" 
}
variable "aws_key_name" { 
  description = "Key-Pair name from the region." 
}
variable "availability_zone1" { 
  default = "us-east-2a" 
}

variable "tag_name_prefix" {
  description = "Provide a common tag prefix value that will be used in the name tag for all resources"
  default = "FTF1000"
}
variable "vpc_cidr_block" {
  description = "VPC Global IPv4 Block"
  default = "10.0.0.0/16"
}
variable "subnet1_block" {
  default = "10.0.101.0/24"
}
variable "subnet1_ip_gw" {
  default = "10.0.101.1"
}
variable "subnet1_ip_fg1" {
  default = "10.0.101.5"
}
variable "subnet2_block" {
  default = "10.0.102.0/24"
}
variable "subnet2_ip_gw" {
  default = "10.0.102.1"
}
variable "subnet2_ip_fg1" {
  default = "10.0.102.5"
}
variable "subnet3_block" {
  default = "10.0.200.0/24"
}
variable "subnet3_ip_fg1" {
  default = "10.0.200.5"
}
variable "fg1_license" { default = "licenses/fg1.lic" }
variable "instance_type" { default = "c5.xlarge" }