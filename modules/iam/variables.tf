variable "tenancy_ocid" {
  description = "OCID del tenancy de OCI"
  type        = string
}

variable "env" {
  description = "Entorno donde aplicar los recursos"
  type        = string
}

variable "tags" {
  description = "Tags para aplicar a los recursos"
  type        = map(string)
  default     = {}
}