output "ec2_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = module.swiftly_server.ec2_public_ip
}

output "swiftly_server_ec2_public_ip" {
  description = "Public IP address of the swiftly-server EC2 instance"
  value       = module.swiftly_server.ec2_public_ip
}

output "iam_access_key_id" {
  description = "IAM Access Key ID for GitHub Actions"
  value       = module.swiftly_server.iam_access_key_id
}

output "iam_secret_access_key" {
  description = "IAM Secret Access Key for GitHub Actions"
  value       = module.swiftly_server.iam_secret_access_key
  sensitive   = true
}

output "ssh_private_key_pem" {
  description = "Private key for SSH access"
  value       = module.swiftly_server.ssh_private_key_pem
  sensitive   = true
}

output "swiftly_server_ssh_private_key_pem" {
  description = "Private key for SSH access to the swiftly-server EC2 instance"
  value       = module.swiftly_server.ssh_private_key_pem
  sensitive   = true
}
