# group

resource "oci_identity_group" "env_group" {
    compartment_id = var.tenancy_ocid
    name = "${var.env}-group"
    description = "Group for ${var.env} environment"
}

# policy

resource "oci_identity_policy" "env_policy" {
    compartment_id = var.tenancy_ocid
    name = "${var.env}-policy"
    description = "Policy for ${var.env} group"
    statements = [
        "Allow group ${var.env}-group to manage all-resources in compartment ${var.env}"
    ]
}