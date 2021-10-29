locals {
  node_name_suffix = "${var.cluster_id}.${var.base_domain}"

  rke2_additional_node_params = "--label plan.upgrade.cattle.io/focal="
}

resource "cloudscale_network" "privnet" {
  name                    = "privnet-${var.cluster_id}"
  zone_slug               = "${var.region}1"
  auto_create_ipv4_subnet = false
}

resource "cloudscale_subnet" "privnet_subnet" {
  network_uuid    = cloudscale_network.privnet.id
  cidr            = var.privnet_cidr
  gateway_address = cidrhost(var.privnet_cidr, 1)
}
