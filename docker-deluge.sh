#!/bin/sh
#
# Docker Image source
# https://hub.docker.com/r/linuxserver/gsm-ts3/

USER=$('whoami')
NAME='deluge'

PUID=`id --user`
PGID=`id --group`

DIR_CONFIG='/home/'$USER'/'$NAME'/config/'
DIR_AUTOADD='/home/'$USER'/'$NAME'/autoadd/'
DIR_COMPLETE='/home/'$USER'/'$NAME'/complete/'
DIR_DOWNLOAD='/home/'$USER'/'$NAME'/download/'
DIR_TORRENT='/home/'$USER'/'$NAME'/torrent/'

mkdir -p $DIR_CONFIG
mkdir -p $DIR_AUTOADD
mkdir -p $DIR_COMPLETE
mkdir -p $DIR_DOWNLOAD
mkdir -p $DIR_TORRENT

docker run -d \
--name=$NAME \
--network=host \
-e PUID=$PUID \
-e PGID=$PGID \
-v $DIR_CONFIG:/config \
-v $DIR_AUTOADD:/autoadd \
-v $DIR_COMPLETE:/complete \
-v $DIR_DOWNLOAD:/download \
-v $DIR_TORRENT:/torrent \
-v /etc/localtime:/etc/localtime:ro \
--restart=always \
linuxserver/deluge
