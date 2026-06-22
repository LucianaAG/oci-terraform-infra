subnets = { # datos de configuración para crear las subnets

    dev = {
        cidr = "172.16.0.0/24"
        dns_label = "dev"
        is_public = true
    }

    dev2 = {
        cidr = "172.16.1.0/24"
        dns_label = "dev2"
        is_public = true
    }
    
}