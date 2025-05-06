resource "google_compute_network" "main_network" {
  name                    = "main-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "main_subnetwork" {
  name          = "main-subnet"
  ip_cidr_range = "10.0.0.0/27"
  network       = google_compute_network.main_network.id
}
