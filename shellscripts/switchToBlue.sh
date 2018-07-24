#!/bin/bash

#change load balance config
sftp ubuntu@192.168.56.101 <<< $'put haproxy.cfg haproxy/tmp/'
ssh ubuntu@192.168.56.101 'docker cp haproxy/tmp/haproxy.cfg parcelsize:/usr/local/etc/haproxy/'
ssh ubuntu@192.168.56.101 'docker kill -s HUP parcelsize'


. versions
#upload new image to repository
if [ -z ${parcelsize} ]; 
then
	echo "parcelsize is unset";
	echo "parcelsize="$1>>versions
else
	sed -i 's/^parcelsize=.*/parcelsize='$1'/g' versions
fi

sftp vagrant@192.168.56.105 <<< $'put parcelsize www/images/'
sftp vagrant@192.168.56.105 <<< $'put versions www/images/'
