#!/bin/bash

vagrant ssh -c 'docker stop -t=0 mysql-pc-size'
vagrant ssh -c 'docker stop -t=0 webserver'

vagrant ssh -c 'docker rm mysql-pc-size'
vagrant ssh -c 'docker rm webserver'

for i in $(seq 1 $1)
do
	vagrant ssh -c 'docker stop -t=0 parcelconfig-size-service_'$i
	vagrant ssh -c 'docker rm parcelconfig-size-service_'$1
done



vagrant halt 

#stopping all containers, removing them and removing all images
#ssh -p 3022 vm-uat@127.0.0.1 'docker-compose stop -d | docker rm $(docker ps -a -q) | docker rmi $(docker images -q)'

#deleting all transfered files
#ssh -p 3302 vm-uat@127.0.0.1 'rm parcelconfig-main parcelconfig-size parcel-size.component.js docker-compose.yml'