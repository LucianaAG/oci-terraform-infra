terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "~> 8.18.0"
    }
  }

  cloud {
    organization = "oci-devops-portfolio"

    workspaces {
      name = "oci-dev"
    }
  }
}