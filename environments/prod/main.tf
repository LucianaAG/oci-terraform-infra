#provider "oci" { # definicion del proveedor a utilizar
 # region              = var.region
  #auth                = "SecurityToken" 
  #config_file_profile = "DEFAULT" # del archivo de config generado por la CLI de oci va a extraer la key para conectarse a OCI
#}

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
  subnets = var.subnets
}

module "compute" {
  source = "../../modules/compute"

  compartment_id = var.compartment_id
  instance_name = var.instance_name
  instance_shape = var.instance_shape
  subnet_ids = module.network.subnet_ids
}