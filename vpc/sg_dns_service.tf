/*
Security Group rules for DNS services
*/

resource "aws_security_group" "dns_service" {
  name = "dns_service"
  description = "Allow all inbound dns services"
  vpc_id = "${aws_vpc.main.id}"

  tags {
    ManagedBy = "Terraform"
  }
}

resource "aws_security_group_rule" "allow_dns_tcp" {
  security_group_id = "${aws_security_group.dns_service.id}"
  type = "ingress"
  from_port = 53
  to_port = 53
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_dns_udp" {
  security_group_id = "${aws_security_group.dns_service.id}"
  type = "ingress"
  from_port = 53
  to_port = 53
  protocol = "udp"
  cidr_blocks = ["0.0.0.0/0"]
}

// Output Variables

output "sg_dns_id" { value = "${aws_security_group.dns_service.id}"}
