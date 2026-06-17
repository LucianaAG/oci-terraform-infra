# Este archivo contiene datos sensibles, y debe ser incluido en el .gitignore
# si se desea levantar infra en una region o compartimento diferente, solo hay que modificar este archivo
# ya que la idea de este archivo, es centralizar los datos sensibles en un punto, para mantener la seguridad
# y no tener que cambiar del archivo principal de forma manual mil veces la region y nuevo compartimento
# donde levantar nueva infra

compartment_id = "ocid1.tenancy.oc1..aaaaaaaa25hbpnjtdci4awubjicawvd4nqtjmnxsg5nlhrxnnral5kthxg5a"
region = "sa-saopaulo-1"