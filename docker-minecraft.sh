#!/bin/sh
#
# Docker Image source
# https://hub.docker.com/r/linuxserver/mcmyadmin2/

USER=$('whoami')
NAME='minecraft'

PUID=`id --user`
PGID=`id --group`

DIR='/home/'$USER'/'$NAME'/'

mkdir -p $DIR

docker run -d \
--name=$NAME \
-e PUID=$PUID \
-e PGID=$PGID \
-p 8080:8080 \
-p 25565:25565 \
-v $DIR:/minecraft \
-v /etc/localtime:/etc/localtime:ro \
--restart=always \
linuxserver/mcmyadmin2
