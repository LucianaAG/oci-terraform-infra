# Este archivo contiene los valores para las configuraciones especificas por entorno
# Como el shape, rango IP, nombre de las instancias, etc.

vcn_cidr = "10.0.0.0/20"

env = "prod"

subnets = { # datos de configuración para crear las subnets

    dev = {
        cidr = "172.16.0.0/24"
        dns_label = "principal_prod_vcn"
        is_public = true
    }

    dev2 = {
        cidr = "172.16.1.0/24"
        dns_label = "secondary_prod_vcn"
        is_public = true
    }
    
}