terraform {
  cloud {
    organization = "oci-infra-portfolio"
    workspaces {
      name = "oci-dev"
    }
  }
}