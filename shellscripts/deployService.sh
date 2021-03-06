#!/bin/bash

#get version number of current running service
wget http://192.168.56.105/images/versions
. versions
v=$parcelsize

#tag image with version number
docker tag $(docker images --filter=reference=parcelsize:latest --format "{{.ID}}") parcelsize:$1
docker save -o parcelsize parcelsize:$1

#transfer docker image to production vm
sftp ubuntu@192.168.56.101 <<< $'put parcelsize images/'

#load docker image to local docker registry and start container
ssh ubuntu@192.168.56.101 'docker load -i images/parcelsize'

sshcmd='docker ps --filter ancestor=parcelsize:'$v' --format "{{.Names}}"'
echo $sshcmd

result=$(ssh ubuntu@192.168.56.101 $sshcmd)
var=1
for i in $result
do
	port=$(expr 1100 + $var)
	ssh ubuntu@192.168.56.101 'docker run -p '$port':1100 --name parcelsize-service_'$var' --net parcelconfig-net -d parcelsize:'$1
	rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi
	var=$((var+1))
done	 

#load js file to webserver
ssh vagrant@192.168.56.105 'mv /var/www/html/js/parcel-size.component.js /var/www/html/js/parcel-size.component_old.js'
sftp vagrant@192.168.56.105 <<< $'put web/js/parcel-size.component.js /var/www/html/js/'


