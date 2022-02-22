locals {
  rke2_base_command = rancher2_cluster_v2.cluster.cluster_registration_token[0].node_command

  api_fqdn = "api.${var.cluster_id}.${var.base_domain}"
}

resource "rancher2_cluster_v2" "cluster" {
  name = var.cluster_id

  kubernetes_version    = var.cluster_kubernetes_version
  enable_network_policy = var.enable_network_policy

  rke_config {
    additional_manifest = var.additional_manifest
    machine_global_config = yamlencode({
      cni = var.cluster_cni_plugin,
      tls-san = [
        local.api_fqdn
      ],
    })
    etcd {
      disable_snapshots      = var.cluster_etcd_snapshots.disabled
      snapshot_retention     = var.cluster_etcd_snapshots.retention_count
      snapshot_schedule_cron = var.cluster_etcd_snapshots.schedule_cron
    }
    machine_selector_config {
      config = {
        protect-kernel-defaults = false
      }
    }
  }

  local_auth_endpoint {
    enabled = true
    fqdn    = local.api_fqdn
  }

  lifecycle {
    ignore_changes = [
      resource_version
    ]
  }
}
