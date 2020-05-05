output "output" {
  value = <<EOL

#
##AWS Components Created
#
${aws_vpc.vpc1.arn}
  ${aws_vpc.vpc1.tags.Name} // ${aws_vpc.vpc1.cidr_block}

#Admin Access:
# FG -- admin / ${aws_instance.fg1.id}
#   ssh admin@${aws_eip.fg1_port1.public_ip} // admin ${aws_instance.fg1.id}
#   https://${aws_eip.fg1_port1.public_ip}

#VPN GW Access
#   ${aws_eip.fg1_port2.public_ip}

  EOL
}