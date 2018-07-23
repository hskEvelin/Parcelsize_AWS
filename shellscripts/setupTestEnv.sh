#!/bin/bash

#starten der VM
vagrant up

#speichern des aktuellen Docker Images des MS
docker save -o parcelsize parcelsize

#laden der Docker images vom Asset-Server
wget http://192.168.56.103/images/parcelwebserver

echo 'laden der Docker images '
#laden der Docker images
vagrant ssh -c 'docker load -i /vagrant/parcelsize'
vagrant ssh -c 'docker load -i /vagrant/parcelwebserver'

#starten der docker container
echo 'starten der Docker images '
vagrant ssh -c 'docker network create parcelconfig-net'

vagrant ssh -c 'docker run --name webserver --net parcelconfig-net -p 8888:8080 -d parcelwebserver'
vagrant ssh -c 'docker run --name parcelservice --net parcelconfig-net -p 1100:1100 -d parcelsize'
vagrant ssh -c 'docker run --name mysql-parcelsize --net parcelconfig-net -p 3306:3306 -d -e MYSQL_ROOT_PASSWORD=mysqlroot --mount type=bind,src=/vagrant/scripts/,dst=/docker-entrypoint-initdb.d/ mysql:5.7.22'


