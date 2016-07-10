resource "aws_instance" "haproxy" {
        ami = "ami-6869aa05"
        instance_type = "t2.nano"
        security_groups = ["${var.sg_id}"]
        subnet_id = "${var.haproxy_subnet}"
        key_name = "${var.pem_name}"
        user_data = "${template_file.haproxy.rendered}"
        tags {
                Name = "haproxy"
        }
}

resource "aws_instance" "web01" {
        ami = "ami-6869aa05"
        instance_type = "t2.nano"
        security_groups = ["${var.sg_id}"]
        subnet_id = "${var.haproxy_subnet}"
        key_name = "${var.pem_name}"
        user_data = "${template_file.web.rendered}"
        tags {
                Name = "web"
        }
}

resource "aws_instance" "web02" {
        ami = "ami-6869aa05"
        instance_type = "t2.nano"
        security_groups = ["${var.sg_id}"]
        subnet_id = "${var.haproxy_subnet}"
        key_name = "${var.pem_name}"
        user_data = "${template_file.web.rendered}"
        tags {
                Name = "web"
        }
}
