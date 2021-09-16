module "git" {
  source = "git::https://github.com/appuio/terraform-modules.git//modules/hiera-git?ref=skeleton-and-lb"

  count = local.lb_count > 0 ? 1 : 0

  hieradata_repo_user = var.hieradata_repo_user
  cluster_id          = var.cluster_id
  content             = local.content
}
