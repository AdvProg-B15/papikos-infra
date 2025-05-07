resource "google_compute_address" "master_ip" {
  name = "master-ip"
}

resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "google_compute_instance" "master" {
  name         = "master"
  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }

  # Add generated SSH privkey to the master node
  metadata_startup_script = <<-EOF
    echo '${tls_private_key.ssh_key.private_key_pem}' > /home/ubuntu/.ssh/id_rsa
    chmod 600 /home/ubuntu/.ssh/id_rsa
    chown ubuntu:ubuntu /home/ubuntu/.ssh/id_rsa
    echo '${tls_private_key.ssh_key.public_key_openssh}' >> /home/ubuntu/.ssh/authorized_keys
  EOF

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

  # Add generated SSH privkey to the master node
  metadata_startup_script = <<-EOF
    mkdir -p /home/ubuntu/.ssh
    echo '${tls_private_key.ssh_key.public_key_openssh}' >> /home/ubuntu/.ssh/authorized_keys
    chmod 700 /home/ubuntu/.ssh
    chmod 600 /home/ubuntu/.ssh/authorized_keys
    chown -R ubuntu:ubuntu /home/ubuntu/.ssh
  EOF

  network_interface {
    subnetwork = var.network_name
  }

  metadata = {
    ssh-keys = join(" ", [for key, value in var.ssh_keys : format("%s:%s", key, value)])
  }

  zone = var.zone
}
