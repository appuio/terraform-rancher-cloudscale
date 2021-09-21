locals {
  anti_affinity_capacity    = 4
  anti_affinity_group_count = ceil(var.node_count / local.anti_affinity_capacity)

  instance_fqdns = formatlist("%s.${var.node_name_suffix}", random_id.node[*].hex)

  common_user_data = {
    "package_update"   = true,
    "package_upgrade"  = true,
    "manage_etc_hosts" = true,
  }
}

resource "random_id" "node" {
  count       = var.node_count
  prefix      = "${var.role}-"
  byte_length = 2
}

resource "cloudscale_server_group" "nodes" {
  count     = var.node_count != 0 ? local.anti_affinity_group_count : 0
  name      = "${var.role}-group"
  type      = "anti-affinity"
  zone_slug = "${var.region}1"
}

resource "cloudscale_server" "node" {
  count            = var.node_count
  name             = "${random_id.node[count.index].hex}.${var.node_name_suffix}"
  zone_slug        = "${var.region}1"
  flavor_slug      = var.flavor_slug
  image_slug       = var.image_slug
  server_group_ids = var.node_count != 0 ? [cloudscale_server_group.nodes[floor(count.index / local.anti_affinity_capacity)].id] : []
  volume_size_gb   = var.volume_size_gb
  ssh_keys         = var.ssh_keys
  interfaces {
    type = "private"
    addresses {
      subnet_uuid = var.subnet_uuid
    }
  }

  user_data = format("#cloud-config\n%s", yamlencode(merge(
    merge(
      local.common_user_data,
      var.additional_user_data
    ),
    {
      "fqdn"     = local.instance_fqdns[count.index],
      "hostname" = random_id.node[count.index].hex,
    }
  )))

  lifecycle {
    ignore_changes = [
      skip_waiting_for_ssh_host_keys,
      image_slug,
    ]
  }
}
