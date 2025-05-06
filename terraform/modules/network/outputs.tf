output "network_name" {
  value = google_compute_network.main_network.name
}

output "subnetwork_name" {
  value = google_compute_subnetwork.main_subnetwork.name
}
