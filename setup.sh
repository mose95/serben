#!/bin/sh


apt update

# Giulio
apt install git \
            wget \
            curl \
            bzip2 \
            zip \
            unzip \
            rar \
            unrar \
            p7zip-full \
            w3m \
            nmap \
            net-tools \
            dos2unix \
            zsh \
            htop \
            nload

# Mose
apt install htop nload

# Mose - Docker install
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
apt-add-repository 'deb https://apt.dockerproject.org/repo ubuntu-xenial main'
apt-get update
apt install -y docker-engine
adduser --gecos "Docker User,,," --disabled-password dockeruser
gpasswd -a dockeruser docker
