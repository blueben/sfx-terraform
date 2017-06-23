/*
Security Group rules for HTTP services
*/

resource "aws_security_group" "http_service" {
  name = "http_service"
  description = "Allow all inbound http services"
  vpc_id = "${aws_vpc.main.id}"

  tags = {
    ManagedBy = "Terraform"
  }
}

resource "aws_security_group_rule" "allow_http_80" {
  security_group_id = "${aws_security_group.http_service.id}"
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_http_443" {
  security_group_id = "${aws_security_group.http_service.id}"
  type = "ingress"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

// Output Variables

output "sg_http_id" { value = "${aws_security_group.http_service.id}"}
