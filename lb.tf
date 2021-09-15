module "lb" {
  source = "git::https://github.com/appuio/terraform-modules.git//modules/lb-cloudscale?ref=skeleton-and-lb"

  router_ip_addresses      = module.worker.ip_addresses[*]
  bootstrap_node           = var.bootstrap_count > 0 ? cidrhost(var.privnet_cidr, 10) : ""
  node_name_suffix         = local.node_name_suffix
  cluster_id               = var.cluster_id
  region                   = var.region
  ssh_keys                 = var.ssh_keys
  privnet_id               = cloudscale_network.privnet.id
  privnet_cidr             = var.privnet_cidr
  lb_count                 = var.lb_count
  lb_cloudscale_api_secret = var.lb_cloudscale_api_secret
  hieradata_repo_user      = var.hieradata_repo_user
  control_vshn_net_token   = var.control_vshn_net_token
}
