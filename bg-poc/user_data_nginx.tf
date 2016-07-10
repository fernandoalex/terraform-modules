resource "template_file" "web" {
        template = <<EOF
#!/bin/bash

yum install nginx tcpdump -y
chkconfig nginx on
echo `ifconfig eth0 | grep addr ` > /usr/share/nginx/html/index.html
service nginx start
EOF
}
