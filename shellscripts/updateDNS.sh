#!/bin/bash

#get new IP-Address from AWS EC2
ipaddr=$(vagrant ssh -c 'curl http://169.254.169.254/latest/meta-data/public-ipv4')
echo  "IP-Address of EC2: "$ipaddr
#update bind9 DNS database
sftp -oPort=2200 vagrant@127.0.0.1:repository/dns/db.parcel.aps.com db.parcel.aps.com.update
sed -i 's/<'$1'>/'$ipaddr'/g' db.parcel.aps.com.update

#transfer database file to DNS server
sftp -oPort=2222 vagrant@127.0.0.1 <<< $'put db.parcel.aps.com.update .'
ssh -p 2222 vagrant@127.0.0.1 'sudo mv db.parcel.aps.com.update /etc/bind/zones/db.parcel.aps.com'

#restart DNS service
ssh -p 2222 vagrant@127.0.0.1 'sudo service bind9 restart'