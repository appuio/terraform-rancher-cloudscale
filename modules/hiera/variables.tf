variable "router_ip_addresses" {
  type        = list(string)
  description = "Private IPV4 addresses of nodes running ingress routers"
}

variable "node_name_suffix" {
  type        = string
  description = "Suffix to use for node names"
}

variable "cluster_id" {
  type        = string
  description = "ID of the cluster"
}

variable "privnet_cidr" {
  default     = "172.18.200.0/24"
  description = "CIDR of the private net to use"
}

variable "lb_names" {
  description = "The hostnames of the loadbalancers"
  type        = list(string)
}

variable "lb_cloudscale_api_secret" {
  type = string
}

variable "hieradata_repo_user" {
  type = string
}

variable "api_vip_network" {
  type = string
}

variable "nat_vip_network" {
  type = string
}

variable "router_vip_network" {
  type = string
}
