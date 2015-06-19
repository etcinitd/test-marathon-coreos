FROM debian

RUN apt-get update && apt-get install -y openjdk-7-jre-headless wget
RUN wget -q -O - http://apache.mirrors.pair.com/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz | tar -xzf - -C /opt \
    && mv /opt/zookeeper-3.4.6 /opt/zookeeper \
    && cp /opt/zookeeper/conf/zoo_sample.cfg /opt/zookeeper/conf/zoo.cfg \
    && mkdir -p /tmp/zookeeper

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

RUN mkdir -p /opt/zookeeper/.docker/
ADD zoo_template.cfg /opt/zookeeper/conf/zoo_template.cfg
ADD start.sh /opt/zookeeper/.docker/start.sh

WORKDIR /opt/zookeeper/
CMD ["/bin/bash", "/opt/zookeeper/.docker/start.sh"]

EXPOSE 2181 2888 3888
