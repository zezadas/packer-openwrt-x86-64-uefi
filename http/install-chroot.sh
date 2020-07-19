#!/bin/sh
set -eufx

export PATH=/bin/:/sbin/:/usr/bin/:/usr/sbin/
echo -e "vagrant\nvagrant\n" | passwd root

#mkdir -p /var/lock
#echo "nameserver 1.1.1.1" > /etc/resolv.conf

# uci set network.lan.proto=dhcp
# uci delete network.lan.type
# uci delete network.lan.ipaddr
# uci delete network.lan.netmask
# uci delete network.lan.ip6assign
# uci commit
# ifdown lan
# ifup lan

#wget -O /tmp/shutdown http://{{.HTTPIP}}:{{.HTTPPort}}/shutdown
chmod a+x /tmp/shutdown

#wget -O /tmp/p1 http://{{.HTTPIP}}:{{.HTTPPort}}/p1
sh /tmp/p1
echo -e "vagrant\nvagrant\n" | passwd vagrant
#wget -O ./p2 http://{{.HTTPIP}}:{{.HTTPPort}}/p2
sh /tmp/p2
