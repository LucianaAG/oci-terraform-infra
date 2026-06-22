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

# crea una subnet con los datos de configuración definidos en el object map del .tfvars

resource "oci_core_subnet" "this" {
  for_each = var.subnets

  vcn_id = oci_core_vcn.internal.id
  cidr_block = each.value.cidr
  compartment_id = var.compartment_id
  display_name = each.key
  prohibit_public_ip_on_vnic = !each.value.is_public
  dns_label = each.value.dns_label
  route_table_id = oci_core_route_table.public_rt.id
}





