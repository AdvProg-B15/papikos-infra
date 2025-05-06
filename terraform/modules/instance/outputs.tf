output "private_node_ips" {
  value = [for node in google_compute_instance.node : node.network_interface[0].network_ip]
}

output "master_ip" {
  value = google_compute_address.master_ip.address
}

output "master_user" {
  value = "ubuntu"
}
