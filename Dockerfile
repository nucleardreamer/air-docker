FROM ubuntu:trusty

MAINTAINER Flynn Joffray <nucleardreamer@gmail.com>
LABEL AUTHOR="Flynn Joffray <nucleardreamer@gmail.com>"
LABEL NAME="air-docker"
LABEL VERSION="0.1.0"

ARG DEBIAN_FRONTEND=noninteractive

RUN dpkg --add-architecture i386 && \
  echo 'deb http://old-releases.ubuntu.com/ubuntu/ raring main restricted universe multiverse' >> /etc/apt/sources.list && \
  apt-get update -y && \
  apt-get install -y -q \
  libudev-dev \
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
  touch /root/.appdata/Adobe/AIR/UpdateDisabled && \
  touch /root/.appdata/Adobe/AIR/eulaAccepted

ENV DISPLAY=:0
