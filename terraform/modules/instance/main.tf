resource "google_compute_address" "master_ip" {
  name = "master-ip"
}

resource "google_compute_instance" "master" {
  name         = "master"
  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }

  network_interface {
    subnetwork = var.network_name

    access_config {
      nat_ip = google_compute_address.master_ip.address
    }
  }

  metadata = {
    ssh-keys = join(" ", [for key, value in var.ssh_keys : format("%s:%s", key, value)])
  }

  zone = var.zone
}

resource "google_compute_instance" "node" {
  for_each     = toset(var.vm_names)
  name         = each.key
  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }

  network_interface {
    subnetwork = var.network_name
    network_ip = "10.0.0.${index(var.vm_names, each.key) + 2}"
  }

  zone = var.zone
}
