#!/bin/bash

# Configure Marathon and start it
ZK_URL=`echo "$NCP_MASTERS" | sed -e 's/ /:2181,/g' -e 's/$/:2181/g'`
LIBPROCESS_IP=${NCP_IP} LIBPROCESS_PORT=9090 /marathon/bin/start \
    --hostname ${NCP_IP} \
    --master "zk://${ZK_URL}/mesos" \
    --zk "zk://${ZK_URL}/marathon" \
    --checkpoint \
    --task_launch_timeout 300000 \
    --local_port_min 31000 \
    --local_port_max 32000
