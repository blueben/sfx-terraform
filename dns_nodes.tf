/*
Terraform config for Seattlefenix
*/

// Provision DNS servers
/*
resource "aws_instance" "dns" {
	count = "${var.ns_nodes}"
	ami = "${lookup(var.ami_centos, var.region)}"
	instance_type = "t2.nano"

	subnet_id = "${element(split(",", module.vpc.pubnet_ids), count.index)}"
	vpc_security_group_ids = ["${module.vpc.sg_default_id}","${module.vpc.sg_dns_id}"]

	tags {
		Identity = "Name Server"
		ManagedBy = "Terraform"
	}
}

resource "aws_eip" "dns_eip" {
	count = "${var.ns_nodes}"
	instance = "${element(join(",", aws_instance.dns.*.id), count.index)}"
	vpc = true
}

resource "aws_ebs_volume" "dns_ebs" {
	count = "${var.ns_nodes}"
  availability_zone = "${var.region}"
	type = "gp2"
  size = 10
  tags {
      Name = "Root Volume (dns)"
  }
}
*/
