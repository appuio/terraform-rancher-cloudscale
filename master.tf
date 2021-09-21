module "master" {
  source = "./modules/node-group"

  cluster_id       = var.cluster_id
  region           = var.region
  role             = "master"
  node_count       = var.master_count
  node_name_suffix = local.node_name_suffix
  image_slug       = var.image_slug
  flavor_slug      = "plus-16"
  subnet_uuid      = cloudscale_subnet.privnet_subnet.id
  ssh_keys         = var.node_ssh_keys
}
