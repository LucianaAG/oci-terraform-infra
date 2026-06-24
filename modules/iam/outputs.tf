output "group_id" {
  description = "Group ID"
  value       = oci_identity_group.env_group.id
}

output "policy_id" {
  description = "Policy ID"
  value       = oci_identity_policy.env_policy.id
}