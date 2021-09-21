output "ip_addresses" {
  value = cloudscale_server.node[*].private_ipv4_address
}
