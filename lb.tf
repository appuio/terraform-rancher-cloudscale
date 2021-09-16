module "lb" {
  source = "git::https://github.com/appuio/terraform-modules.git//modules/lb-cloudscale?ref=skeleton-and-lb"

  node_name_suffix       = local.node_name_suffix
  cluster_id             = var.cluster_id
  region                 = var.region
  ssh_keys               = var.ssh_keys
  privnet_id             = cloudscale_network.privnet.id
  lb_count               = var.lb_count
  control_vshn_net_token = var.control_vshn_net_token
}
