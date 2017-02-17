#!/bin/bash

NGINX_VERSION=1.11.8
NGINX_SRC=/nginx_source

apt-get install libpcre3-dev build-essential libssl-dev -y && \
    mkdir ${NGINX_SRC} && \
    wget -O /nginx_source.tar.gz http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz && \
    tar -zxvf /nginx_source.tar.gz -C ${NGINX_SRC} --strip-components=1 && \
    cd ${NGINX_SRC} && \
    ./configure \
    --prefix=/opt/nginx \
    --sbin-path=/usr/sbin \
    --with-stream && \
    make && \
    make install && \
    rm -rf /nginx_source.tar.gz ${NGINX_SRC}

