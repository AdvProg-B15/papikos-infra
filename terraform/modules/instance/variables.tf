variable "vm_names" {
  type    = list(string)
  default = ["node-1", "node-2", "node-3", "node-4", "node-5", "node-6"]
}

variable "zone" {
  type = string
}

variable "network_name" {
  type = string
}

variable "ssh_keys" {
  type = map(string)
}
