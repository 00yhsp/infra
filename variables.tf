variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-northeast-2"
}

variable "admin_ip" {
  description = "Administrator IP address for SSH access (e.g., 1.2.3.4/32)"
  type        = string
}

variable "project_name" {
  description = "Project name for tagging and naming"
  type        = string
  default     = "swiftly-server"
}

variable "environment" {
  description = "Environment (e.g., prod, dev)"
  type        = string
  default     = "prod"
}
