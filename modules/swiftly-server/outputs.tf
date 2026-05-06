output "ec2_public_ip" {
  value = aws_instance.app_server.public_ip
}

output "iam_access_key_id" {
  value = aws_iam_access_key.github_actions_key.id
}

output "iam_secret_access_key" {
  value     = aws_iam_access_key.github_actions_key.secret
  sensitive = true
}

output "ssh_private_key_pem" {
  value     = tls_private_key.ssh_key.private_key_pem
  sensitive = true
}
