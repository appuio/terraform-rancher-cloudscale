module "hiera" {
  source = "git::https://github.com/appuio/terraform-modules.git//modules/lb-vshn-hiera?ref=skeleton-and-lb"

  api_backends             = formatlist("etcd-%d.${local.node_name_suffix}", range(3))
  router_backends          = module.worker.ip_addresses[*]
  node_name_suffix         = local.node_name_suffix
  cluster_id               = var.cluster_id
  lb_names                 = module.lb.server_names
  lb_cloudscale_api_secret = var.lb_cloudscale_api_secret
  hieradata_repo_user      = var.hieradata_repo_user
  api_vip                  = cidrhost(module.lb.api_vip[0].network, 0)
  internal_vip             = cidrhost(var.privnet_cidr, 100)
  nat_vip                  = cidrhost(module.lb.nat_vip[0].network, 0)
  router_vip               = cidrhost(module.lb.router_vip[0].network, 0)
}
