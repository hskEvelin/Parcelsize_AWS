FROM haproxy:1.6.14
RUN groupadd haproxy && useradd -g haproxy haproxy

RUN mkdir /var/lib/haproxy
RUN mkdir /run/haproxy
RUN mkdir /dev/log
COPY haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg
