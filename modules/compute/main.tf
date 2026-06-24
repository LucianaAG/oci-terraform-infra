# obtener dominio de disponibilidad
data "oci_identity_availability_domains" "ads" {
  compartment_id = var.compartment_id
}

data "oci_core_images" "ol_images" {
  compartment_id           = var.compartment_id
  operating_system         = "Oracle Linux"
  operating_system_version = "8"
  shape                    = "VM.Standard.E2.1.Micro"
}

# instancia
resource "oci_core_instance" "app_server" {
  compartment_id      = var.compartment_id
  display_name        = var.instance_name
  shape               = var.instance_shape
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  freeform_tags       = var.tags

  source_details {
    source_type = "image"
    source_id   = data.oci_core_images.ol_images.images[0].id
  }

  create_vnic_details {
    subnet_id        = values(var.subnet_ids)[0]
    assign_public_ip = true
  }
}