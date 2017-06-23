/*
Default security group rules
*/

resource "aws_security_group" "global" {
  name = "global"
  description = "Default security group, applied to all nodes"
  vpc_id = "${aws_vpc.main.id}"

  tags {
    ManagedBy = "Terraform"
  }
}

resource "aws_security_group_rule" "allow_outbound" {
  security_group_id = "${aws_security_group.global.id}"
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_ssh" {
  security_group_id = "${aws_security_group.global.id}"
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_icmp" {
  security_group_id = "${aws_security_group.global.id}"
  type = "ingress"
  from_port = 0
  to_port = 0
  protocol = "icmp"
  cidr_blocks = ["0.0.0.0/0"]
}

// Output Variables

output "sg_default_id" { value = "${aws_security_group.global.id}"}
