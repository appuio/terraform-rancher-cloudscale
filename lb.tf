module "lb" {
  source = "git::https://github.com/appuio/terraform-modules.git//modules/vshn-lbaas-cloudscale?ref=v1.0.0"

  node_name_suffix       = local.node_name_suffix
  cluster_id             = var.cluster_id
  region                 = var.region
  ssh_keys               = var.ssh_keys
  privnet_id             = cloudscale_network.privnet.id
  lb_count               = var.lb_count
  control_vshn_net_token = var.control_vshn_net_token

  router_backends          = module.worker.ip_addresses[*]
  lb_cloudscale_api_secret = var.lb_cloudscale_api_secret
  hieradata_repo_user      = var.hieradata_repo_user
}
