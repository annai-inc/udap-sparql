FROM ubuntu:xenial
MAINTAINER Yoshikazu Aoyama <yskz.aoyama@gmail.com>

RUN apt-get update -y \
    && apt-get install -y git autoconf automake libtool flex bison gperf gawk m4 make openssl libssh-dev net-tools \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/cache/apt/archives/*

RUN git clone --branch v7.2.4.2 https://github.com/openlink/virtuoso-opensource.git /usr/local/src/virtuoso-opensource \
    && cd /usr/local/src/virtuoso-opensource \
    && ./autogen.sh \
    && ./configure CFLAGS="-O2 -m64" \
    && make \
    && make install \
    && make clean

CMD /usr/local/virtuoso-opensource/bin/virtuoso-t +foreground +configfile /usr/local/virtuoso-opensource/var/lib/virtuoso/db/virtuoso.ini
