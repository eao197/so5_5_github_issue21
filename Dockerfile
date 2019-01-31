FROM ubuntu:16.04 as issue21-check

# Prepare build environment
RUN apt-get update && \
    apt-get -qq -y install gcc g++ libtool git

WORKDIR /root

