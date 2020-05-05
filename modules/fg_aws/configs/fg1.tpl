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

--===============HEREDOC==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="license"

${fg1_license}

--===============HEREDOC==--