terraform {
  cloud {
    organization = "oci-devops-portfolio"
    workspaces {
      name = "oci-dev"
    }
  }
}