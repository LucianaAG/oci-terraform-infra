# este archivo muestra los datos que nosotros indiquemos en la salida al lanzar el "terraform apply"
# en este caso, por ejemplo, mostramos el estado de la VCN y su CIDR, pero podriamos por tener una instancia
# de servidor y mostrar en la salida su IP

output "vcn_state" {
    description = "the state of the VCN"
    value = oci_core_vcn.internal.state
}

output "vcn_cidr" {
    description = "CIDR block of the core VCN"
    value = oci_core_vcn.internal.cidr_block
}