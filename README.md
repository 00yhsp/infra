# Centralized Infrastructure Management

이 레포지토리는 전사 프로젝트의 공용 인프라 자원을 중앙집중식으로 관리하는 Terraform 코드 저장소입니다.

## 🏗 아키텍처 원칙

- **중앙 관리**: 모든 프로젝트의 인프라를 한 곳에서 관리하여 일관성 있는 정책을 유지합니다.
- **모듈화**: 각 프로젝트는 `modules/` 디렉토리 내에 독립적인 모듈로 구성됩니다.
- **표준화**: 공통 태깅 정책(`Project`, `Environment`, `ManagedBy`) 및 보안 규칙을 준수합니다.

## 📂 프로젝트 온보딩 현황

1. **`swiftly-server` (Onboarded)**
   - 첫 번째 온보딩 프로젝트입니다.
   - AWS EC2, Docker/Docker Compose 환경을 제공합니다.

## 🚀 시작하기

### 1. 전제 조건

- Terraform v1.5.0 이상
- Cloudflare R2 버킷 (Terraform State 관리용)

### 2. Terraform 초기화 (Backend 설정)

Cloudflare R2를 백엔드로 사용하므로 초기화 시 다음과 같이 백엔드 설정을 명시해야 합니다.

```bash
terraform init \
  -backend-config="endpoint=https://<CLOUDFLARE_ACCOUNT_ID>.r2.cloudflarestorage.com" \
  -backend-config="bucket=<BUCKET_NAME>" \
  -backend-config="key=terraform.tfstate" \
  -backend-config="region=auto" \
  -backend-config="access_key=<R2_ACCESS_KEY_ID>" \
  -backend-config="secret_key=<R2_SECRET_ACCESS_KEY>" \
  -backend-config="skip_credentials_validation=true" \
  -backend-config="skip_region_validation=true" \
  -backend-config="skip_requesting_account_id=true" \
  -backend-config="skip_metadata_api_check=true" \
  -backend-config="s3_use_path_style=true"
```

### 3. 인프라 배포

```bash
# 새로운 프로젝트 추가 시 main.tf에서 모듈을 호출하세요.
terraform plan -var="admin_ip=<YOUR_IP>/32"
terraform apply -var="admin_ip=<YOUR_IP>/32"
```

## 🔐 CI/CD 연동 가이드

`terraform apply` 완료 후 출력되는 값을 해당 프로젝트 레포지토리의 GitHub Actions Secrets에 등록하십시오.

| Secret Name | Terraform Output | Description |
| :--- | :--- | :--- |
| `EC2_PUBLIC_IP` | `ec2_public_ip` | EC2 인스턴스의 퍼블릭 IP |
| `SSH_KEY` | `ssh_private_key_pem` | EC2 접속용 SSH Private Key |
| `AWS_ACCESS_KEY_ID` | `iam_access_key_id` | 배포용 IAM User Access Key |
| `AWS_SECRET_ACCESS_KEY` | `iam_secret_access_key` | 배포용 IAM User Secret Key |

## 🔌 모듈별 SSH 접속

Terraform output에 저장된 EC2 IP와 SSH private key를 사용해 모듈별 EC2에 접속할 수 있습니다. SSH key는 파일로 저장하지 않고 임시 `ssh-agent`에만 추가됩니다.

접속 대상 모듈은 다음 root output 규칙을 따라야 합니다. 모듈 이름의 `-`는 output 이름에서 `_`로 바꿉니다.

```hcl
output "<module>_ec2_public_ip" {}
output "<module>_ssh_private_key_pem" {
  sensitive = true
}
```

새 output을 추가한 뒤에는 `terraform apply`를 실행해 Terraform state에 output을 반영해야 합니다.

```bash
make ssh MODULE=swiftly-server
./scripts/ssh-module swiftly-server
./scripts/ssh-module swiftly-server -- "docker compose ps"
```
