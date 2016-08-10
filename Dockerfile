FROM ubuntu:trusty

ARG DEBIAN_FRONTEND=noninteractive

RUN dpkg --add-architecture i386 && \
  echo 'deb http://old-releases.ubuntu.com/ubuntu/ raring main restricted universe multiverse' >> /etc/apt/sources.list && \
  apt-get update -y && \
  apt-get install -y \
  libudev-dev \
  build-essential \
  ia32-libs

WORKDIR /air
COPY . /air
RUN dpkg -i adobeair_2.6.0.19170_amd64.deb && \
  ln -s /opt/Adobe\ AIR/Versions/1.0/Adobe\ AIR\ Application\ Installer /usr/local/bin/air-install

ENV DISPLAY=:0
