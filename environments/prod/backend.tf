terraform { # conectamos el ambiente con su respectivo workspace en HCP
  cloud {
    organization = "oci-infra-portfolio"
    workspaces {
      name = "oci-prod"
    }
  }
}
