#!/bin/bash

# Call mesos with configuration generated from our environment variables
MESOS_ZK=`echo "$NCP_MASTERS" | sed -e 's/ /:2181,/g' -e 's/$/:2181/g'`
MESOS_QUORUM=`expr ${NCP_NUM_MASTERS} / 2 + 1`
mesos-master \
    --ip=${NCP_IP} \
    --hostname=${NCP_IP} \
    --zk="zk://${MESOS_ZK}/mesos" \
    --work_dir=/var/lib/mesos/master \
    --quorum=${MESOS_QUORUM} \
    --log_auto_initialize \
    --registry_fetch_timeout=1mins
