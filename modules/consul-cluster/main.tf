resource "linode_token" "bootstrap" {
  scopes = "linodes:read_only"
  label  = "${var.cluster_name}-bootstrap"
  expiry = timeadd(timestamp(), "10m")
}

resource "linode_instance" "consul_instance" {
  count = var.cluster_size

  label = "${var.cluster_name}-${count.index}"
  image = var.image_id
  # TODO region-count product
  region = var.region
  type = var.instance_type
  authorized_keys = var.ssh_keys
  # TODO: clean up role-server magic string
  tags = concat([
    var.cluster_tag_name,
    "${var.cluster_tag_name}-role-${var.role}",
  ], var.tags)
  swap_size = 256
  private_ip = true

  provisioner "file" {
    connection {
      host  = self.ip_address
      type  = "ssh"
      user  = "root"
      agent = "true"
    }

    content     = "[DEFAULT]\n token = ${linode_token.bootstrap.token}\n region=${var.region}\n type=${var.instance_type}\n image=${var.image_id}\n"
    destination = "/root/.linode-cli"
  }

  provisioner "remote-exec" {
    connection {
      host  = self.ip_address
      type  = "ssh"
      user  = "root"
      agent = "true"
    }

    inline = [
      "/opt/consul/bin/run-consul --${var.role} --datacenter ${var.region} --cluster-tag-name ${var.cluster_tag_name} --environment LINODE_TOKEN=${linode_token.bootstrap.token}",
    ]
  }
}
