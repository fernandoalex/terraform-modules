resource "template_file" "haproxy" {
        vars {
                web1_ip = "${aws_instance.web01.private_ip}"
                web2_ip = "${aws_instance.web02.private_ip}"
        }
        template = <<EOF
#!/bin/bash

yum install haproxy tcpdump -y
chkconfig haproxy on

cat <<AAA > /etc/haproxy/haproxy.cfg
global
    log         127.0.0.1 local2

    chroot      /var/lib/haproxy
    pidfile     /var/run/haproxy.pid
    maxconn     4000
    user        haproxy
    group       haproxy
    daemon

defaults
    mode                    http
    log                     global
    option                  httplog
    option                  dontlognull
    option http-server-close
    option forwardfor       except 127.0.0.0/8
    option                  redispatch
    retries                 3
    timeout http-request    10s
    timeout queue           1m
    timeout connect         10s
    timeout client          1m
    timeout server          1m
    timeout http-keep-alive 10s
    timeout check           10s
    maxconn                 3000

frontend  main *:80
    	acl app2 hdr_sub(header_key)  value

	use_backend app2 if app2
	default_backend             app

backend app
    balance     roundrobin
    server  app1 ${web1_ip}:80 check
    server  app2 ${web2_ip}:80 check
backend app2
    balance     roundrobin
    server  app2 ${web2_ip}:80 check
AAA

service haproxy start
EOF
}
