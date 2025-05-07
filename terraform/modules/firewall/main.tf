resource "google_compute_firewall" "allow_ssh" {
  name    = "advprog-allow-ssh"
  network = var.network_name

  direction = "INGRESS"
  priority  = 1001

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow_http" {
  name    = "advprog-allow-http"
  network = var.network_name

  direction = "INGRESS"
  priority  = 1001

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow_https" {
  name    = "advprog-allow-https"
  network = var.network_name

  direction = "INGRESS"
  priority  = 1001

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow_internal" {
  name    = "advprog-allow-internal"
  network = var.network_name

  allow {
    protocol = "tcp"
    ports = ["0-65535"]
  }

  source_ranges      = ["10.0.0.0/27"]
  destination_ranges = ["10.0.0.0/27"]
}
