variable "region" {
  description = "region de oci"
  type        = string
}


variable "fingerprint" {
  description = "Fingerprint de la API key del usuario root"
  type        = string
}

variable "prod_user_ocid" {
  description = "OCID del usuario de servicio de prod"
  type        = string
}

variable "dev_user_ocid" {
  description = "OCID del usuario de servicio de dev"
  type        = string
}

variable "tenancy_ocid" {
  description = "OCID del tenancy"
  type        = string
}

variable "user_ocid" {
  description = "OCID del usuario root para el bootstrap"
  type        = string
}

variable "private_key" {
  description = "Private key del usuario root"
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "Tag para los recursos"
  type        = map(string)
  default     = {}
}