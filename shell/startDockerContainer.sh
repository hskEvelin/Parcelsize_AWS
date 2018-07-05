#!/bin/bash

vagrant ssh -c 'docker run --name=mysql-pc-size --mount type=bind,src=/vagrant/scripts/,dst=/docker-entrypoint-initdb.d/ --net parcelconfig-net -e=MYSQL_ROOT_PASSWORD="mysql" -d mysql/mysql-server:5.7.21'

#wait some time for mysql database to start
sleep 5s

#start docker containers on remote machine
#vagrant ssh -c 'docker-compose up -d'
vagrant ssh -c 'docker run --name=webserver --net parcelconfig-net -p 1150:8080 -d parcelconfig-main'
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

for i in $(seq 1 $1)
do
	port=$(expr $2 + $i)
	vagrant ssh -c 'docker run --name=parcelconfig-size-service_'$i' --net parcelconfig-net -p '$port':1100 -d parcelconfig-size'
	rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi
done
