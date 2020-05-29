Content-Type: multipart/mixed; boundary="===============HEREDOC=="
MIME-Version: 1.0

--===============HEREDOC==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="config"

config system global
  set hostname FG1
  set admintimeout 60
end
config system interface
  edit port1
    set mode static
    set ip ${subnet1_ip_fg1}
    set allowaccess https ping ssh fgfm
    set alias public
  next
  edit port2
    set allowaccess ping
    set vrf 1
    set alias vpngw
  next
  edit port3
    set allowaccess ping
    set alias inside
  next
end
config router static
  edit 1
    set device port1
    set gateway ${subnet1_ip_gw}
  next
  edit 2
    set device port2
    set gateway ${subnet2_ip_gw}
  next
end
config user local
 edit "sslvpnuser"
                set type password
                set passwd ${sslpassword}
end
config user group
  edit "SSLVPNGroup"
 	set member "sslvpnuser"
end
config vpn ssl settings
 set https-redirect enable
 set servercert "self-sign"
 set tunnel-ip-pools "SSLVPN_TUNNEL_ADDR1"
 set tunnel-ipv6-pools "SSLVPN_TUNNEL_IPv6_ADDR1"
 set port 443
 set source-interface "port2"
 set source-address "all"
 set source-address6 "all"
 set default-portal "tunnel-access"
end
config firewall policy
 edit 1
  set name "AllowSSLvpn"
  set uuid e6f659bc-a0f7-51ea-1281-d462dbd5acca
  set srcintf "ssl.root"
  set dstintf "port3"
  set srcaddr "SSLVPN_TUNNEL_ADDR1"
  set dstaddr "all"
  set action accept
  set schedule "always"
  set service "ALL"
  set utm-status enable
  set ssl-ssh-profile "certificate-inspection"
  set av-profile "default"
  set ips-sensor "default"
  set groups "SSLVPNGroup"
  set nat enable
end

--===============HEREDOC==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="license"

${fg1_license}

--===============HEREDOC==--