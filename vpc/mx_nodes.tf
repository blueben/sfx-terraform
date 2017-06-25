/*
Terraform config for Seattlefenix
*/

// Provision Mail Exchange node resources

resource "random_pet" "mx" {
  keepers = {
    # Generate a new id each time we switch to a new AMI id
    ami_id = "${data.aws_ami.ubuntu1704.id}"
  }
}

resource "aws_eip" "mx" {
	count = "${var.mx_nodes}"
	vpc = true
}

resource "aws_ebs_volume" "mx_primary" {
	count = "${var.mx_nodes}"
	availability_zone = "${element(aws_subnet.public.*.availability_zone, count.index)}"
	type = "gp2"
  size = 10
	lifecycle = {
		prevent_destroy = true
	}

  tags {
    Name = "mx${count.index} data"
		Service = "mx"
		ManagedBy = "Terraform"
  }
}

resource "aws_network_interface" "mx" {
	subnet_id = "${element(aws_subnet.public.*.id, count.index)}"
	security_groups = ["${aws_security_group.global.id}","${aws_security_group.mail_service.id}"]

	tags {
    Name = "mx${count.index} interface"
		Service = "mx"
		ManagedBy = "Terraform"
  }
}

resource "aws_instance" "mx" {
	count = "${var.mx_nodes}"
	ami = "${random_pet.mx.keepers.ami_id}"
	instance_type = "t2.nano"
	key_name = "seattlefenix"

	root_block_device {
		volume_type = "gp2"
  	volume_size = 8
	}

	volume_tags {
		Name = "${random_pet.mx.id}-mx${count.index}"
		Service = "mx"
		ManagedBy = "Terraform"
	}

	network_interface {
		network_interface_id = "${element(aws_network_interface.mx.*.id, count.index)}"
		device_index = 0
	}

	tags {
		Name = "${random_pet.mx.id}-mx${count.index}"
		Service = "mx"
		ManagedBy = "Terraform"
	}
}

resource "aws_volume_attachment" "mx_primary" {
	count = "${var.mx_nodes}"
  device_name = "/dev/sde"
  volume_id   = "${element(aws_ebs_volume.mx_primary.*.id, count.index)}"
  instance_id = "${element(aws_instance.mx.*.id, count.index)}"
}

resource "aws_eip_association" "mx" {
	count = "${var.mx_nodes}"
  instance_id   = "${element(aws_instance.mx.*.id, count.index)}"
  allocation_id = "${element(aws_eip.mx.*.id, count.index)}"
}
