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