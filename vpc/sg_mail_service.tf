/*
Security group rules for mail services
*/

resource "aws_security_group" "mail_service" {
  name = "mail_services"
  description = "Allow all inbound mail services"
  vpc_id = "${aws_vpc.main.id}"

  tags {
    ManagedBy = "Terraform"
  }
}

resource "aws_security_group_rule" "allow_smtp_25" {
  security_group_id = "${aws_security_group.mail_service.id}"
  type = "ingress"
  from_port = 25
  to_port = 25
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_imap_143" {
  security_group_id = "${aws_security_group.mail_service.id}"
  type = "ingress"
  from_port = 143
  to_port = 143
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_smtp_587" {
  security_group_id = "${aws_security_group.mail_service.id}"
  type = "ingress"
  from_port = 587
  to_port = 587
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_imap_993" {
  security_group_id = "${aws_security_group.mail_service.id}"
  type = "ingress"
  from_port = 993
  to_port = 993
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

// Output Variables

output "sg_mail_id" { value = "${aws_security_group.mail_service.id}"}
