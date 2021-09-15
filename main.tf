locals {
  node_name_suffix = "${var.cluster_id}.${var.base_domain}"

  node_additional_user_data = {
    "write_files" = [
      {
        path       = "/etc/hosts.allow"
        "encoding" = "b64"
        "owner"    = "root:root"
        "permissions" : "0644"

        "content" = base64encode(format("sshd: %s", join(",", formatlist("%s!/32", module.lb.servers[*].private_ipv4_address))))
      }
    ]
  }
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
