variable "compartment_id" {
    description = "OCI from my tenancy page"
    type = string
}

variable "region" {
    description = "region where i have OCI tenancy" 
    type = string
    default = "sa-saopaulo-1"
}

variable "instance_name" {
  description = "Nombre para mostrar de la instancia en OCI."
  type        = string
  default     = "learn-terraform"
}

variable "tenancy_ocid" {
  description = "OCID del tenancy de OCI."
  type        = string
}

variable "user_ocid" {
  description = "OCID del usuario de OCI."
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