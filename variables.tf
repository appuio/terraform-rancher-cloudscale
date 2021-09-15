variable "cluster_id" {
  type        = string
  description = "ID of the cluster"
}

variable "base_domain" {
  type        = string
  description = "Base domain of the cluster"
}

variable "region" {
  type        = string
  description = "Region where to deploy nodes"
}

variable "ssh_keys" {
  type        = list(string)
  description = "SSH keys to add to LBs"
  default     = []
}

variable "node_ssh_keys" {
  type        = list(string)
  description = "SSH keys to add to cluster nodes"
  default     = []
}

variable "privnet_cidr" {
  default     = "172.18.200.0/24"
  description = "CIDR of the private net to use"
}

variable "bootstrap_count" {
  type    = number
  default = 0
}

variable "lb_count" {
  type    = number
  default = 2
}

variable "master_count" {
  type    = number
  default = 3
}

variable "worker_count" {
  type        = number
  default     = 3
  description = "Number of worker nodes"
}

variable "worker_flavor" {
  type        = string
  default     = "plus-16"
  description = "Flavor to use for worker nodes"
}

variable "worker_volume_size_gb" {
  type        = number
  description = "Worker boot volume size in GBs"
  default     = 128
}

variable "additional_worker_groups" {
  type    = map(object({ flavor = string, count = number, volume_size_gb = optional(number) }))
  default = {}

  validation {
    condition = alltrue([
      for k, v in var.additional_worker_groups :
      !contains(["worker", "master"], k) &&
      v.count >= 0 &&
      (v.volume_size_gb != null ? v.volume_size_gb >= 120 : true)
    ])
    // Cannot use any of the nicer string formatting options because
    // error_message validation is dumb, cf.
    // https://github.com/hashicorp/terraform/issues/24123
    error_message = "Your configuration of `additional_worker_groups` violates one of the following constraints:\n * The worker disk size cannot be smaller than 120GB.\n * Additional worker group names cannot be 'worker' or 'master'.\n * The worker count cannot be less than 0."
  }
}

variable "image_slug" {
  type        = string
  description = "Image to use for nodes"
  default     = "ubuntu-20.04"
}

variable "lb_cloudscale_api_secret" {
  type = string
}

variable "hieradata_repo_user" {
  type = string
}

variable "control_vshn_net_token" {
  type = string
}
