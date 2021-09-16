locals {
  instance_fqdns = formatlist("%s.${var.node_name_suffix}", var.lb_names)

  lb_count = length(var.lb_names)

  content = templatefile(
    "${path.module}/templates/hieradata.yaml.tmpl",
    {
      "cluster_id"   = var.cluster_id
      "api_vip"      = cidrhost(var.api_vip_network, 0)
      "router_vip"   = cidrhost(var.router_vip_network, 0)
      "api_secret"   = var.lb_cloudscale_api_secret
      "internal_vip" = cidrhost(var.privnet_cidr, 100)
      "nat_vip"      = cidrhost(var.nat_vip_network, 0)
      "nodes"        = local.instance_fqdns
      "backends" = {
        "api"    = formatlist("etcd-%d.${var.node_name_suffix}", range(3))
        "router" = var.router_ip_addresses[*],
      }
  })
}
