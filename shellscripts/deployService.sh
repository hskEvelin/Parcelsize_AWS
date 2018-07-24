#!/bin/bash

#get version number of current running service
sftp -oPort=2200 vagrant@127.0.0.1:www/images/versions versions
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
var=3
for i in $result
do
	port=$(expr 1100 + $var)
	ssh ubuntu@192.168.56.101 'docker run -p '$port':1100 --name parcelsize-service_'$var' --net parcelconfig-net -d parcelsize:'$1
	rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi
	var=$((var+1))
done	 

#load js file to webserver
sftp -oPort=2200 vagrant@127.0.0.1 <<< $'put web/js/parcel-size.component.js www/js/'


