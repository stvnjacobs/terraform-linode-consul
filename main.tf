# ----------------------------------------------------------------------------------------------------------------------
# REQUIRE A SPECIFIC TERRAFORM VERSION OR HIGHER
# This module has been updated with 0.12 syntax, which means it is no longer compatible with any versions below 0.12.
# ----------------------------------------------------------------------------------------------------------------------
terraform {
  required_version = ">= 0.12"
}

data "linode_image" "consul" {
  id = var.image_id
}

# ---------------------------------------------------------------------------------------------------------------------
# DEPLOY THE CONSUL SERVER NODES
# ---------------------------------------------------------------------------------------------------------------------

module "consul_servers" {
  source = "./modules/consul-cluster"

  role = "server"
  cluster_name  = "${var.cluster_name}-server"
  cluster_size  = var.num_servers
  cluster_tag_name   = var.cluster_tag_name
  image_id = var.image_id
  instance_type = "g6-standard-1"
  region = var.region
  ssh_keys = var.ssh_keys
  tags = var.tags
}

module "consul_clients" {
  source = "./modules/consul-cluster"

  role = "client"
  cluster_name  = "${var.cluster_name}-client"
  cluster_size  = var.num_clients
  cluster_tag_name   = var.cluster_tag_name
  image_id = var.image_id
  instance_type = "g6-standard-1"
  region = var.region
  ssh_keys = var.ssh_keys
  tags = var.tags
}
