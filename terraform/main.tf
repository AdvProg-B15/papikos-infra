# Network
module "network_create" {
  source = "./modules/network"
}

# Firewall
module "firewall_create" {
  source       = "./modules/firewall"
  network_name = module.network_create.network_name
}

locals {

  # SSH Setup
  ssh_keys = (
    var.ssh_keys != null ?
    var.ssh_keys :
    { "ubuntu" : file("~/.ssh/id_rsa.pub") }
  )
}

# Instances
module "instance" {
  source       = "./modules/instance"
  vm_names     = var.vm_names
  zone         = var.zone
  ssh_keys     = local.ssh_keys
  network_name = module.network_create.subnetwork_name
}

resource "local_file" "ansible_inventory" {
  depends_on = [module.instance]
  content = templatefile(
    "../hosts.ini",
    {
      master_host = module.instance.master_ip
      master_user = module.instance.master_user
      nodes       = module.instance.private_node_ips
    }
  )
  filename = "../inventory.ini"
}
