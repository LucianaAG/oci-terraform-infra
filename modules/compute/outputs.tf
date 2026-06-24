output "instance_public_ip" {
  description = "public IP of the OCI instance"
  value       = oci_core_instance.app_server.public_ip
}