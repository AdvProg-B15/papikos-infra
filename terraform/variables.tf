variable "project_name" {
  type    = string
  default = "belajar-kube-457207"
}

variable "region" {
  type    = string
  default = "australia-southeast1"
}

variable "zone" {
  type    = string
  default = "australia-southeast1-a"
}

variable "vm_names" {
  type    = list(string)
  default = ["node-1", "node-2", "node-3", "node-4", "node-5", "node-6"]
}

variable "ssh_keys" {
  type    = map(string)
  default = null
}
