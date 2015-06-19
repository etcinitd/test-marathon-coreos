#!/bin/bash

# Call mesos with configuration generated from our environment variables
MESOS_ZK=`echo "$NCP_MASTERS" | sed -e 's/ /:2181,/g' -e 's/$/:2181/g'`
mesos-slave \
    --master="zk://${MESOS_ZK}/mesos" \
    --ip=${NCP_IP} \
    --hostname=${NCP_IP} \
    --containerizers="docker,mesos" \
    --executor_registration_timeout=5mins \
    --resources=ports:[31000-32000] \
    --work_dir=/var/lib/mesos/slave \
    --log_dir=/var/log/mesos/slave
