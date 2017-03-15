#!/bin/sh
#
# Docker Image source
# https://hub.docker.com/r/linuxserver/gsm-ts3/

USER=$('whoami')
NAME='teamspeak3'

PUID=`id --user`
PGID=`id --group`

DIR_CONFIG='/home/'$USER'/'$NAME'/config/'

mkdir -p $DIR_CONFIG

docker run -d \
--name=$NAME \
--network=host \
-e PUID=$PUID \
-e PGID=$PGID \
-v $DIR_CONFIG:/config \
-v /etc/localtime:/etc/localtime:ro \
--restart=always \
linuxserver/gsm-ts3
