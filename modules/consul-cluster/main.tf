resource "linode_token" "readonly" {
  count  = var.cluster_size
  scopes = "linodes:read_only"
  label  = "${var.cluster_name}-${count.index}"
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
  tags = concat([var.cluster_tag_name], var.tags)
  swap_size = 256
  private_ip = true

# must set `LINODE_TOKEN` env for -retry-join
# see modules/run-consul
# https://www.consul.io/docs/agent/cloud-auto-join.html#linode


  provisioner "remote-exec" {
    connection {
      host  = self.ip_address
      type  = "ssh"
      user  = "root"
      agent = "true"
    }

    inline = [
      "/usr/local/bin/run-consul --${var.role} --cluster-tag-name ${var.cluster_tag_name} --environment LINODE_TOKEN=${linode_token.readonly[count.index].token} --environment LINODE_CLI_TOKEN=${linode_token.readonly[count.index].token}",
    ]
  }
}
