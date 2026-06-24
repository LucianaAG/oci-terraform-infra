variable "compartment_id" {
  description = "OCI from my tenancy page"
  type        = string
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

variable "subnet_ids" { # OCI genera automaticamente los IDs de las subnets al generarlas
  description = "Id de la subnet"
  type        = map(string)
}

variable "tags" {
  description = "Tags para aplicar a los recursos"
  type        = map(string)
  default     = {}
}