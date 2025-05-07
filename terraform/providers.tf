terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.30.0"
    }
    tls = {
      source = "hashicorp/tls"
      version = "~> 4.1.0"
    }
  }
}

provider "google" {
  project = var.project_name
  region  = var.region
}
