# OCI Terraform Infra

Infra en OCI manejada con Terraform. Dos entornos (dev y prod), módulos separados por tipo de recurso y state remoto en HCP.

## Qué levanta

Cada entorno despliega lo siguiente dentro de su propio compartment:

- VCN con dos subnets públicas
- Internet Gateway + Route Table
- Security List con acceso por SSH (22) y HTTP (80)
- Instancia de cómputo con Oracle Linux 8
- Grupo IAM y policy para el entorno

## Estructura

```
oci-terraform-infra/
├── environments/
│   ├── dev/
│   │   ├── backend.tf        # workspace oci-dev en HCP
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── dev.auto.tfvars   # CIDRs, shapes, tags del entorno
│   └── prod/
│       ├── backend.tf        # workspace oci-prod en HCP
│       ├── main.tf
│       ├── variables.tf
│       └── prod.auto.tfvars
└── modules/
    ├── network/    # VCN, subnets, IGW, route table, security list
    ├── compute/    # instancia + data sources
    └── iam/        # grupo y policy por entorno
```

## Requisitos

- Terraform >= 1.5
- Cuenta en OCI con API Key en formato RSA
- Dos workspaces en HCP Terraform (`oci-dev` y `oci-prod`) conectados a este repo

## Cómo usarlo

Las credenciales van en HCP como variables sensibles, no en el repo.

Variables que hay que cargar en cada workspace:

| Variable | Sensible |
|----------|----------|
| `tenancy_ocid` | Sí |
| `user_ocid` | Sí |
| `fingerprint` | Sí |
| `private_key` | Sí |
| `compartment_id` | Sí |
| `region` | No |

Cada push a `main` dispara un plan automático en HCP. Para aprobarlo, entrá al workspace y confirmá el apply.

Para correr un plan local:

```bash
cd environments/dev
terraform init
terraform plan
```

## Variables por entorno

Se definen en el `auto.tfvars` de cada entorno y sí van al repo porque no son sensibles.

| Variable | dev | prod |
|----------|-----|------|
| `vcn_cidr` | `172.16.0.0/20` | `10.0.0.0/20` |
| `instance_shape` | `VM.Standard.E2.1.Micro` | `VM.Standard.A1.Flex` |
| `env` | `dev` | `prod` |

## Por qué está hecho así

**Módulos por tipo de recurso**
Todo lo de red en `network`, todo lo de cómputo en `compute`, IAM aparte. Si hay que tocar la instancia, no hay que mirar código de red.

**Un entorno, un directorio**
Dev y prod tienen sus propios archivos de configuración. Un apply en dev no toca prod nunca, porque cada workspace tiene su propio state en HCP.

**Credenciales fuera del repo**
Las variables sensibles viven en HCP. El repo no tiene ningún secret, se puede clonar sin riesgo.

**`versions.tf` en cada módulo**
Sin esto, HCP resuelve el provider OCI como `hashicorp/oci` (deprecado) en lugar de `oracle/oci`. Cada módulo lo declara explícitamente para evitar ese problema.

## Próximo

- Vault para no depender de variables manuales en HCP
- Subnet privada con NAT Gateway para el backend
- NSGs en lugar de Security Lists para control de tráfico por VNIC
- Monitoreo con Prometheus + Grafana
