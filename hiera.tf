module "hiera" {
  source = "git::https://github.com/appuio/terraform-modules.git//modules/lb-vshn-hiera?ref=skeleton-and-lb"

  router_ip_addresses      = module.worker.ip_addresses[*]
  node_name_suffix         = local.node_name_suffix
  cluster_id               = var.cluster_id
  privnet_cidr             = var.privnet_cidr
  lb_names                 = module.lb.server_names
  lb_cloudscale_api_secret = var.lb_cloudscale_api_secret
  hieradata_repo_user      = var.hieradata_repo_user
  api_vip_network          = module.lb.api_vip[0].network
  nat_vip_network          = module.lb.nat_vip[0].network
  router_vip_network       = module.lb.router_vip[0].network
}
