FROM ubuntu:trusty

MAINTAINER Flynn Joffray <nucleardreamer@gmail.com>
LABEL AUTHOR="Flynn Joffray <nucleardreamer@gmail.com>"
LABEL NAME="air-docker"
LABEL VERSION="0.2.0"

ARG DEBIAN_FRONTEND=noninteractive

RUN dpkg --add-architecture i386 && \
  echo 'deb http://old-releases.ubuntu.com/ubuntu/ raring main restricted universe multiverse' >> /etc/apt/sources.list && \
  apt-get update -y && \
  apt-get install -y -q \
  build-essential \
  psmisc \
  ia32-libs

RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /air
COPY . /air
RUN dpkg -i adobeair_2.6.0.19170_amd64.deb && \
  ln -s /opt/Adobe\ AIR/Versions/1.0/Adobe\ AIR\ Application\ Installer /usr/local/bin/air-install && \
  mkdir -p /root/.appdata/Adobe/AIR && \
  echo 1 > /root/.appdata/Adobe/AIR/UpdateDisabled && \
  echo 1 > /root/.appdata/Adobe/AIR/eulaAccepted && \
  mkdir -p /etc/opt/Adobe\ AIR/ && \
  cp globalRuntime.conf /etc/opt/Adobe\ AIR/

ENV DISPLAY=:0
