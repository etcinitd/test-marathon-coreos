FROM nginx:1.7

# Install wget
RUN apt-get update
RUN apt-get install -y -q wget

# Download and Install Consul Template
RUN wget -O /tmp/consul-template.tar.gz https://github.com/hashicorp/consul-template/releases/download/v0.8.0/consul-template_0.8.0_linux_amd64.tar.gz \
    && mkdir /tmp/consul-template \
    && tar zxf /tmp/consul-template.tar.gz -C /tmp/consul-template \
    && find /tmp/consul-template/ -type f -exec cp \{\} /usr/local/bin/ \;
    && rm -rf consul-template.tar.gz /tmp/consul-template

# Install our default nginx configuration
ADD files/default.conf /etc/nginx/conf.d/default.conf

# Install our nginx template
RUN mkdir /etc/consul-templates && mkdir /etc/consul-template.d
ADD files/nginx.conf /etc/consul-templates/nginx.conf
ADD files/template.json /etc/consul-template.d/template.json

CMD /usr/sbin/nginx -c /etc/nginx/nginx.conf \
    & consul-template \
    -consul ${NCP_IP}:8500 \
    -config /etc/consul-template.d