#!/bin/bash
#copy .js file to remote machine
#sftp -oPort=3022 vm-uat@127.0.0.1 <<< $'put web/js/'$1

#copy .js file into docker container of webserver
#ssh -p 3022 vm-uat@127.0.0.1 'docker cp parcel-size.component.js vmuat_webserver_1:/usr/local/tomcat/webapps/ParcelConfigService/js'
#vagrant ssh -c 'docker cp /vagrant/web/js/parcel-size.component.js vagrant_webserver_1:/usr/local/tomcat/webapps/ParcelConfigService/js'

#publish js to repository server
sftp -oPort=2200 vagrant@127.0.0.1 <<< $'put web/js/parcel-size.component.js repository/js/'
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi


sleep 5s