#!/bin/bash

set -e

# Generate our confict file from our environment variables
mkdir -p /etc/zookeeper/conf
echo "$ZOO_UNIQUE_ID" | tee /opt/zookeeper/conf/myid

# /var/lib/zookeeper is our data directory and it must contain myid!
mkdir -p /var/lib/zookeeper
ln -s -T /opt/zookeeper/conf/myid /var/lib/zookeeper/myid

rm /opt/zookeeper/conf/zoo.cfg || true
cp /opt/zookeeper/conf/zoo_template.cfg /opt/zookeeper/conf/zoo.cfg

# Make sure we don't accidently append to a commented out line by
# adding some whitespace to the end.
echo "" | tee -a /opt/zookeeper/conf/zoo.cfg
echo "" | tee -a /opt/zookeeper/conf/zoo.cfg

# Append our masters
echo "$ZOO_MASTERS" \
    | sed -e 's/ /:2888:3888\n/g' -e 's/$/:2888:3888/g' \
    | nl -w 1 -s " " \
    | sed -e 's/ /=/g' -e 's/^/server./g' \
    | tee -a /opt/zookeeper/conf/zoo.cfg

# Start zookeeper
/opt/zookeeper/bin/zkServer.sh start-foreground
