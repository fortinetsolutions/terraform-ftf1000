## See variables.tf for ALL variables and defaults ##
## Make user defined overrides by copying:         ##
##    terraform-example.tfvars terraform.tfvars    ##

##
##The resource prrefix for all names.
##  The default is the name of this template.
#tag_name_prefix = "prefix"

##
##The AWS Credentials you created in IAM of AWS.
##  The default is "$HOME/.aws/credentials" if not set.
##  Set where aws credentials go in AWS by dewfault
##  Use and edit the file, aws-creds.txt, below.
#aws_creds_file = "aws-creds.txt"

##
##The AWS Instance Key Pair Name
##  You need to create this ahead of time.
aws_key_name = "aws-keyname-user-region"

##
##AWS Resource Information if you do not want the deafults.
#region = "aws-region"
#availability_zone1 = "availability_zone1"
#instance_type = "instance_type"