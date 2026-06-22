terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "~> 8.18.0"
    }
  }

  cloud {
    organization = "oci-infra-portfolio"
    workspaces {
      name = "oci-dev"
    }
  }
}

provider "oci" {
  tenancy_ocid = var.tenancy_ocid
  user_ocid    = var.user_ocid
  fingerprint  = var.fingerprint
  private_key  = var.private_key
  region       = var.region
}

module "network" {
  source = "../../modules/network"

  compartment_id = var.compartment_id
  subnets        = var.subnets
}

module "compute" {
  source = "../../modules/compute"

  compartment_id = var.compartment_id
  instance_name  = var.instance_name
  instance_shape = var.instance_shape
  subnet_ids     = module.network.subnet_ids
}