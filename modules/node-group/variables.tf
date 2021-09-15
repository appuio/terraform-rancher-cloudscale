variable "role" {
  type        = string
  description = "Role of the nodes to be provisioned"
}

variable "node_count" {
  type        = number
  description = "Number of nodes to provision"
}

variable "node_name_suffix" {
  type        = string
  description = "Suffix to use for node names"
}

variable "subnet_uuid" {
  type        = string
  description = "UUID of the subnet in which to create the nodes"
}

variable "region" {
  type        = string
  description = "Region where to deploy nodes"
}

variable "cluster_id" {
  type        = string
  description = "ID of the cluster"
}

variable "flavor_slug" {
  type        = string
  description = "Flavor to use for nodes"
  default     = "plus-16"
}

variable "image_slug" {
  type        = string
  description = "Image to use for nodes"
}

variable "volume_size_gb" {
  type        = number
  description = "Boot volume size in GBs"
  default     = 128
}

variable "additional_user_data" {
  type        = map(any)
  description = "Additional data merged with the common user data"
  default     = {}
}

variable "ssh_keys" {
  type        = list(string)
  description = "SSH keys to add to node group"
  default     = []
}
