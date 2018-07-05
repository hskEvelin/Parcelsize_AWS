#!/bin/bash

#sftp -oPort=2200 vagrant@127.0.0.1:repository/images/versions versions
. versions
v=$parcelconfigsize

if [ -z ${parcelconfigsize} ]; 
then
	echo "parcelconfigoption is unset";
	echo "parcelconfigoption=100">>versions
else
	#parcelconfigoption=$1
	sed -i 's/^parcelconfigsize=.*/parcelconfigsize='$1'/g' versions
fi


#if [ ($parcelconfigoption == "") ]
#then
#	echo "parcelconfigoption=100">>versions
#fi

#echo "Version parcelconfig-size: "$v