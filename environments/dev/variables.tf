# Le dice al entorno dev qué variables espera recibir. Incluye todo lo que el main.tf de dev usa
# tanto las credenciales como las variables que pasa a los módulos.

variable "user_ocid" {
  description = "OCID del usuario de OCI."
  type        = string
}

variable "tenancy_ocid" {
  description = "OCID del tenancy de OCI."
  type        = string
}

variable "fingerprint" {
  description = "Fingerprint de la API key de OCI."
  type        = string
}

variable "private_key" {
  description = "Contenido de la private key de OCI."
  type        = string
  sensitive   = true
}

variable "region" {
    description = "region where i have OCI tenancy" 
    type = string
    default = "sa-saopaulo-1"
}

variable "vcn_cidr" {
  description = "CIDR block para la VCN"
  type = string
}

variable "compartment_id" {
    description = "OCI from my tenancy page"
    type = string
}

variable "instance_name" {
  description = "Nombre para mostrar de la instancia en OCI."
  type        = string
  default     = "learn-terraform"
}

variable "instance_shape" {
  description = "Shape de la instancia OCI."
  type        = string
  default     = "VM.Standard.E2.1.Micro"
}

# objeto map (solamente agregamos los datos individuales de cada subnet)
variable "subnets" {
  type = map(object({
    cidr = string
    dns_label = string
    is_public = bool
  }))
}

variable "env" {
    description = "Entorno donde aplicar los recursos"
    type = string
}