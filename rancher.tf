locals {
  rke2_base_command = rancher2_cluster_v2.cluster.cluster_registration_token[0].node_command

  api_fqdn = "api.${var.cluster_id}.${var.base_domain}"
}

resource "rancher2_cluster_v2" "cluster" {
  name = var.cluster_id

  kubernetes_version    = var.cluster_kubernetes_version
  enable_network_policy = true

  rke_config {
    local_auth_endpoint {
      enabled = true
      fqdn    = local.api_fqdn
    }
    machine_global_config = yamlencode({
      cni = var.cluster_cni_plugin,
      tls-san = [
        local.api_fqdn
      ],
    })
    machine_selector_config {
      config = {
        protect-kernel-defaults = false
      }
    }
  }

  lifecycle {
    ignore_changes = [
      resource_version
    ]
  }
}
