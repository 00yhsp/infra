module "swiftly_server" {
  source = "./modules/swiftly-server"

  aws_region   = var.aws_region
  project_name = var.project_name
  environment  = var.environment
  admin_ip     = var.admin_ip
}
