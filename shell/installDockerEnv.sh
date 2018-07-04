#!/bin/bash

#create VM and start it
echo 'AWS_ACCESS_KEY_ID='$AWS_ACCESS_KEY_ID' AWS_SECRET_ACCESS_KEY='$AWS_SECRET_ACCESS_KEY' SPATH='$SPATH
AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY SPATH=$SPATH vagrant up

./shell/updateDNS.sh parcelconfigsize_testVM

#while [ $# -gt 0 ]
#do
#	img = $1
	#save docker image as tar file, so we can transfer it to remote machine
#	docker save -o $img $img

	#transfer tar file to remote machine via sftp on Port 3022
	#sftp -oPort=3022 vm-uat@127.0.0.1 <<< $'put '$var

	#ssh command to load packed docker image in registry on remote machine
#	vagrant ssh -c 'docker load -i /vagrant/'$img

#	shift
	#start docker containers
#	vagrant ssh -c 'docker run -d -p 1100:1100 '$img
#done

#create docker network
vagrant ssh -c 'docker network create parcelconfig-net'

for var in "$@"
do
   	#save docker image as tar file, so we can transfer it to remote machine
	docker save -o $var $var

	#sync the created docker image
	mv $var sync/
	vagrant rsync
	
	#ssh command to load packed docker image in registry on remote machine
	vagrant ssh -c 'docker load -i /vagrant/'$var

done

#install mysql docker container and load it
docker save -o parcel-mysql mysql/mysql-server:5.7.21
mv parcel-mysql sync/
cp -r scripts sync/
vagrant rsync
vagrant ssh -c 'docker load -i /vagrant/parcel-mysql'

