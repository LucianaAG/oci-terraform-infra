# Este archivo le dice al main.tf que datos necesita recibir para poder funcionar
# Es como la firma de una funcion. Declara los parametros que debe aceptar

variable "compartment_id" {
    description = "OCI from my tenancy page"
    type = string
}

# objeto map (solamente agregamos los datos individuales de cada subnet)
variable "subnets" {
  type = map(object({
    cidr = string
    dns_label = string
    is_public = bool
  }))
}

variable "vcn_cidr" {
  description = "CIDR block para la VCN"
  type = string
}