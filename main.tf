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

# obtener dominio de disponibilidad
data "oci_identity_availability_domains" "ads" {
  compartment_id = var.compartment_id
}

resource "oci_core_vcn" "internal" { # definicion del recurso a utilizar. tipo de recurso / nombre
  dns_label      = "internal"
  cidr_block     = "172.16.0.0/20"
  compartment_id = var.compartment_id
  display_name   = "my internal VCN"
}

# internet gateway
resource "oci_core_internet_gateway" "igw" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.internal.id
  display_name   = "my internet gateway"
  enabled        = true
}

# route table
resource "oci_core_route_table" "public_rt" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.internal.id
  display_name   = "public route table"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.igw.id # gateway de preferencia
  }
}

# subnet publica
resource "oci_core_subnet" "dev" {
  vcn_id                     = oci_core_vcn.internal.id
  cidr_block                 = "172.16.0.0/24"
  compartment_id             = var.compartment_id
  display_name               = "Dev subnet"
  prohibit_public_ip_on_vnic = false  # porque queremos que sea público
  dns_label                  = "dev"
  route_table_id             = oci_core_route_table.public_rt.id
}

# instancia
resource "oci_core_instance" "app_server" {
  compartment_id      = var.compartment_id
  display_name        = var.instance_name
  shape               = var.instance_shape
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name

  source_details {
    source_type = "image"
    source_id   = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaagiuwjxcqfitqof63iu2olh2uvz6nlcwwcwyjsazc5p3qqiznrqda"
  }

  create_vnic_details {
    subnet_id        = oci_core_subnet.dev.id
    assign_public_ip = true
  }
}




