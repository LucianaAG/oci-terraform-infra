output "instance_public_ip" {
  description = "Public IP of the OCI instance"
  value       = module.compute.instance_public_ip
}