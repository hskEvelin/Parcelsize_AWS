#!/bin/bash

#change load balance config
sftp -oPort=2223 vagrant@127.0.0.1 <<< $'put haproxy.cfg haproxy/tmp/'
ssh -p 2223 vagrant@127.0.0.1 'docker cp haproxy/tmp/haproxy.cfg parcelconfig-size:/usr/local/etc/haproxy/'
ssh -p 2223 vagrant@127.0.0.1 'docker kill -s HUP parcelconfig-size'


. versions
#upload new image to repository
if [ -z ${parcelconfigsize} ]; 
then
	echo "parcelconfigsize is unset";
	echo "parcelconfigsize="$1>>versions
else
	sed -i 's/^parcelconfigsize=.*/parcelconfigsize='$1'/g' versions
fi

sftp -oPort=2200 vagrant@127.0.0.1 <<< $'put parcelconfig-size repository/images/'
sftp -oPort=2200 vagrant@127.0.0.1 <<< $'put versions repository/images/'