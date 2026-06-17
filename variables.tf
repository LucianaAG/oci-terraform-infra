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