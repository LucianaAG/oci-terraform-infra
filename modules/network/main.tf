resource "oci_core_vcn" "internal" { # definicion del recurso a utilizar. tipo de recurso / nombre
  dns_label      = "internal"
  cidr_block     = var.vcn_cidr
  compartment_id = var.compartment_id
  display_name   = "my internal VCN"
  freeform_tags  = var.tags
}

resource "oci_core_security_list" "public_sl" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.internal.id
  display_name   = "public security list"
  freeform_tags  = var.tags

  # trafico saliente 
  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "all"
  }

  # trafico entrante SSH
  ingress_security_rules {
    protocol = "6" # TCP
    source   = "0.0.0.0/0"
    tcp_options {
      min = 22
      max = 22
    }
  }

  # trafico entrante HTTP
  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"
    tcp_options {
      min = 80
      max = 80
    }
  }
}

# internet gateway
resource "oci_core_internet_gateway" "igw" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.internal.id
  display_name   = "my internet gateway"
  enabled        = true
  freeform_tags  = var.tags
}

# route table
resource "oci_core_route_table" "public_rt" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.internal.id
  display_name   = "public route table"
  freeform_tags  = var.tags

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.igw.id # gateway de preferencia
  }
}

# crea una subnet con los datos de configuración definidos en el object map del .tfvars

resource "oci_core_subnet" "this" {
  for_each = var.subnets

  vcn_id                     = oci_core_vcn.internal.id
  cidr_block                 = each.value.cidr
  compartment_id             = var.compartment_id
  display_name               = each.key
  prohibit_public_ip_on_vnic = !each.value.is_public
  dns_label                  = each.value.dns_label
  route_table_id             = oci_core_route_table.public_rt.id
  security_list_ids          = [oci_core_security_list.public_sl.id]
  freeform_tags              = var.tags
}





