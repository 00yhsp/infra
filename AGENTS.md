# Codex Agents: Repository Context

This file provides context for Codex-based agents and sub-agents to understand the repository's purpose and operational boundaries.

## 🎯 Repository Purpose
Centralized Infrastructure Management for the Swiftly Ecosystem. This repo manages AWS resources for multiple microservices, starting with `swiftly-server`.

## 🌳 Branching Strategy
- **`main`**: Source of truth for production.
- **`feature/*`**: Scoped work for infrastructure updates.
- All merges to `main` must be via Pull Requests with a verified `terraform plan`.

## 🤖 Agent Roles & Responsibilities
- **Infrastructure Investigator**: Analyze current Terraform state and AWS resource configurations.
- **Provisioning Specialist**: Draft and apply Terraform changes for new services.
- **Security Auditor**: Review Security Groups and IAM policies for compliance.

## 🗝 Key Reference Points
- `INFRA_SPEC.md`: The source of truth for infrastructure requirements.
- `GEMINI.md`: Detailed engineering standards and conventions.
- `modules/swiftly-server/`: Reference implementation for service onboarding.

## 🚫 Constraints
- No manual changes in the AWS Console; everything must be via IaC.
- Do not modify files in the `swiftly-server` application repository directly from this context.
