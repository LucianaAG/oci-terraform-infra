# Este archivo contiene los valores para las configuraciones especificas por entorno
# Como el shape, rango IP, nombre de las instancias, etc.


vcn_cidr = "172.16.0.0/20"

env = "dev"

subnets = { # datos de configuración para crear las subnets

  dev = {
    cidr      = "172.16.2.0/24"
    dns_label = "principal_dev_vcn"
    is_public = true
  }

  dev2 = {
    cidr      = "172.16.3.0/24"
    dns_label = "secondary_prod_vcn"
    is_public = true
  }

}

tags = {
  "environment" = "dev"
  "managed-by"  = "terraform"
  "project"     = "oci-terraform-infra"
}

