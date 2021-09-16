output "hieradata_mr_url" {
  value = local.lb_count > 0 ? module.git[0].hieradata_mr_url : ""
}
