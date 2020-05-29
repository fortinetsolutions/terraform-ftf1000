## Edit this file for most used settings              ##
## Remove pound # from beginning of any variable used ## 
## See variables.tf for ALL variables and defaults    ##

## PREFIX
## The prefix is used for AWS resource names. The default is the name of this template. Avoid using spaces or special characters
#tag_name_prefix = ""

## AWS Credentials
## This variable defines where your AWS Credentials will be entered. It is currently defined in the file "aws-credentials.txt". You need to enter your AWS credentials in the aws-credentials.txt file .Removing or commenting out this variable will default to "$HOME/.aws/credentials".
aws_creds_file = "aws-credentials.txt"

## SSLVPN Password
## This variable defines the password set for the SSLVPN user named sslvpnuser, will default to fortinet123
sslpassword = "fortinet123"

## AWS Instance Key Pair Name
## This is the key name you created in AWS within the region that you are installing. You need to create this ahead of time.
aws_key_name = "awskeyfromregion"

## AWS Region Variables (Default is us-east-2 - OH)
## Uncomment the region and availability zone for which you are installing this instance

##VA
#region = "us-east-1"
#availability_zone1 = "us-east-1a"

##OH
#region = "us-east-2"
#availability_zone1 = "us-east-2a"

##CA
#region = "us-west-1"
#availability_zone1 = "us-west-1b"
#availability_zone1 = "us-west-1c"

##OR
#region = "us-west-2"
#availability_zone1 = "us-west-2a"
#availability_zone1 = "us-west-2b"
#availability_zone1 = "us-west-2c"
#availability_zone1 = "us-west-2d"

## Instance Type
## This is the compute system that the FortiGate will be installed on. Default is c5.xlarge which is 4 CPU and 20GB RAM.
instance_type = "c5.xlarge"

## Networking Configuration
## These variables define the network IP ranges configured for the instance. See README for a simple diagram.

## VPC Defined IP Block
vpc_cidr_block = "10.0.0.0/16"

## WAN 1 IP Range and Firewall IP
subnet1_block = "10.0.101.0/24"
subnet1_ip_gw = "10.0.101.1"
subnet1_ip_fg1 = "10.0.101.5"

## WAN 2 IP Range and Firewall IP - used for secondary public port for VPN
subnet2_block = "10.0.102.0/24"
subnet2_ip_gw = "10.0.102.1"
subnet2_ip_fg1 = "10.0.102.5"

## Trusted IP Range
subnet3_block = "10.0.200.0/24"
subnet3_ip_fg1 = "10.0.200.5"