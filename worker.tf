module "worker" {
  source = "./modules/node-group"

  cluster_id           = var.cluster_id
  region               = var.region
  role                 = "worker"
  node_count           = var.worker_count
  node_name_suffix     = local.node_name_suffix
  image_slug           = var.image_slug
  flavor_slug          = var.worker_flavor
  volume_size_gb       = var.worker_volume_size_gb
  subnet_uuid          = cloudscale_subnet.privnet_subnet.id
  ssh_keys             = var.node_ssh_keys
  additional_user_data = local.node_additional_user_data
}

// Additional worker groups.
// Configured from var.additional_worker_groups
module "additional_worker" {
  for_each = var.additional_worker_groups

  source = "./modules/node-group"

  cluster_id           = var.cluster_id
  region               = var.region
  role                 = each.key
  node_count           = each.value.count
  node_name_suffix     = local.node_name_suffix
  image_slug           = var.image_slug
  flavor_slug          = each.value.flavor
  volume_size_gb       = each.value.volume_size_gb != null ? each.value.volume_size_gb : var.worker_volume_size_gb
  subnet_uuid          = cloudscale_subnet.privnet_subnet.id
  ssh_keys             = var.node_ssh_keys
  additional_user_data = local.node_additional_user_data
}
