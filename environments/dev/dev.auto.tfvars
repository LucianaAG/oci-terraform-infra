# Este archivo contiene los valores para las configuraciones especificas por entorno
# Como el shape, rango IP, nombre de las instancias, etc.

subnets = { # datos de configuración para crear las subnets

    dev = {
        cidr = "172.16.2.0/24"
        dns_label = "dev"
        is_public = true
    }

    dev2 = {
        cidr = "172.16.3.0/24"
        dns_label = "dev2"
        is_public = true
    }
    
}