terraform { # configuraciones de terrraform
  required_providers {
    oci = {
      source = "oracle/oci"
    }
  }
}

# el token de auth es efimero, asi que en caso error
# hay que crear otro desde powershell a traves del comando 
# "oci session authenticate --region sa-saopaulo-1 --profile DEFAULT"
# luego ingresamos "deafult" y el token ya se refresca y podemos levantar la infra

provider "oci" { # definicion del proveedor a utilizar
  region              = var.region
  auth                = "SecurityToken" 
  config_file_profile = "DEFAULT" # del archivo de config generado por la CLI de oci va a extraer la key para conectarse a OCI
}

resource "oci_core_vcn" "internal" { # definicion del recurso a utilizar. tipo de recurso / nombre
  dns_label      = "internal"
  cidr_block     = "172.16.0.0/20"
  compartment_id = var.compartment_id
  display_name   = "my internal VCN"
}

resource "oci_core_subnet" "dev" {
  vcn_id = oci_core_vcn.internal.id 
  cidr_block = "172.16.0.0/24"
  compartment_id = var.compartment_id
  display_name = "Dev subnet"
  prohibit_public_ip_on_vnic = true
  dns_label = "dev"
}