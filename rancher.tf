resource "rancher2_cluster_v2" "cluster" {
  name = var.cluster_id

  kubernetes_version    = var.cluster_kubernetes_version
  enable_network_policy = true

  rke_config {
    local_auth_endpoint {
      enabled = true
      fqdn    = "api.${var.cluster_id}.${var.base_domain}"
    }
    machine_global_config = join("\n", [
      "cni: \"${var.cluster_cni_plugin}\""
    ])
  }

  lifecycle {
    ignore_changes = [
      resource_version
    ]
  }
}
