terraform { # configuraciones de terrraform
  required_providers {
    oci = {
      source = "oracle/oci"
    }
  }

  cloud { # conectamos nuestro proyecto local con HCP
    organization = "oci-devops-portfolio"

    workspaces {
      name = "oci-prod"
    }
  }
}