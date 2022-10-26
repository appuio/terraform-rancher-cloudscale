module "lb" {
  source = "git::https://github.com/appuio/terraform-modules.git//modules/vshn-lbaas-cloudscale?ref=v4.1.0"

  node_name_suffix       = local.node_name_suffix
  cluster_id             = var.cluster_id
  distribution           = "rke"
  ingress_controller     = var.cluster_ingress_controller
  region                 = var.region
  ssh_keys               = var.ssh_keys
  privnet_id             = cloudscale_network.privnet.id
  lb_count               = var.lb_count
  control_vshn_net_token = var.control_vshn_net_token
  team                   = var.team

  api_backends             = module.master.ip_addresses[*]
  router_backends          = module.worker.ip_addresses[*]
  lb_cloudscale_api_secret = var.lb_cloudscale_api_secret
  hieradata_repo_user      = var.hieradata_repo_user
}
