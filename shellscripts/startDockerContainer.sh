#!/bin/bash

#laden der Docker images
docker load -i /vagrant/parcelsize
docker load -i /vagrant/parcelwebserver.tar
docker load -i /vagrant/mysql.tar

#starten der container
#docker network create parcelconfig-net

docker run --name=mysql-parcelsize --mount type=bind,src=/vagrant/scripts/,dst=/docker-entrypoint-initdb.d/ --net parcelconfig-net -e=MYSQL_ROOT_PASSWORD="mysqlroot" -d mysql/mysql-server:5.7.22

#wait some time for mysql database to start
sleep 5s

#start docker containers on remote machine
#vagrant ssh -c 'docker-compose up -d'
docker run --name=webserver --net parcelconfig-net -p 8888:8080 -d parcelwebserver
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

for i in $(seq 1 $1)
do
	port=$(expr $2 + $i)
	docker run --name=parcelsize-service_$i --net parcelconfig-net -p $port:1100 -d parcelsize
	rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi
done
