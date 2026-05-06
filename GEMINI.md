# Swiftly Infrastructure: Project Instructions

This document provides foundational guidance and mandates for Gemini CLI and other AI agents working on this repository.

## 🏗 Architecture & Tech Stack
- **IaC**: Terraform (v1.5+)
- **Provider**: AWS (`ap-northeast-2`)
- **Backend**: Cloudflare R2 (S3-compatible)
- **Pattern**: Modularized by project under `modules/`.

## 🌳 Branching Strategy
- **`main`**: Stable branch. Reflects the actual state of production infrastructure. Directly protected.
- **`feature/*`**: Development branches. Use for adding new modules, updating resources, or refactoring.
- **Workflow**: 
  1. Create `feature/description` branch from `main`.
  2. Apply changes and verify with `terraform validate`.
  3. Open a Pull Request to `main`.
  4. Merge only after successful `terraform plan` review.

## 🛠 Engineering Standards

### Terraform Conventions
- **Naming**: Use kebab-case for resource names (e.g., `app-server-sg`).
- **Modularity**: Every new project or major component must be its own module.
- **Variables**: Always provide descriptions for variables. Avoid hardcoding IDs (use Data Sources instead).
- **Secrets**: Never hardcode credentials. Use `sensitive = true` for outputs containing secrets.

### Tagging Policy
Every AWS resource must have the following tags:
- `Project`: The name of the application (e.g., `swiftly-server`).
- `Environment`: `prod`, `dev`, or `staging`.
- `ManagedBy`: `Terraform`.

### Security
- **SSH Access**: Restricted to `admin_ip`.
- **IAM**: Follow the principle of least privilege (initial setup uses `EC2FullAccess` as a baseline).
- **Keys**: Use automated TLS key generation within Terraform.

## 🔄 Workflows
- **Initialization**: Always require `-backend-config` for Cloudflare R2 during `terraform init`.
- **Validation**: Run `terraform fmt` and `terraform validate` before proposing changes.
- **Deployment**: Use GitHub Actions for deployment, utilizing the outputs defined in the root module.

## 📂 Directory Structure
- `/modules/<project-name>/`: Project-specific infrastructure.
- `main.tf`: Module orchestrator.
- `providers.tf`: Global provider and backend definitions.
