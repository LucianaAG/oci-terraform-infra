terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
    }
  }
}

provider "oci" {
  region       = var.region
  fingerprint  = var.fingerprint
  user_ocid    = var.user_ocid
  tenancy_ocid = var.tenancy_ocid
  private_key  = var.private_key
}

module "iam_dev" {
  source = "../modules/iam"

  tenancy_ocid = var.tenancy_ocid
  env          = "dev"
  tags         = var.tags
  user_ocid    = var.dev_user_ocid
}

module "iam_prod" {
  source = "../modules/iam"

  tenancy_ocid = var.tenancy_ocid
  env          = "prod"
  tags         = var.tags
  user_ocid    = var.prod_user_ocid
}