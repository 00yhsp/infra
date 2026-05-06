# Swiftly Central Infrastructure

이 레포지토리는 Swiftly Ecosystem의 중앙 인프라 관리를 위한 Terraform 코드를 포함하고 있습니다. 첫 번째 서비스로 `swiftly-server`가 온보딩되어 있습니다.

## 🏗 아키텍처 개요

- **Cloud Provider**: AWS
- **Region**: `ap-northeast-2` (Seoul)
- **Compute**: EC2 (`t3.micro` / Amazon Linux 2023)
- **Storage**: 20GB GP3 Root Volume
- **Containerization**: Docker & Docker Compose (자동 설치)
- **State Management**: Cloudflare R2 (S3-compatible backend)

## 🚀 시작하기

### 1. 전제 조건

- Terraform v1.5.0 이상 설치
- AWS CLI 설치 및 자격 증명 설정
- Cloudflare R2 버킷 및 API 토큰 생성 (S3 호환 자격 증명)

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
# 변수 파일(terraform.tfvars) 생성 후 실행 권장
terraform plan -var="admin_ip=<YOUR_IP>/32"
terraform apply -var="admin_ip=<YOUR_IP>/32"
```

## 🔐 CI/CD 연동 가이드

`terraform apply` 완료 후 출력되는 값을 `swiftly-server` 레포지토리의 GitHub Actions Secrets에 등록하십시오.

| Secret Name | Terraform Output | Description |
| :--- | :--- | :--- |
| `EC2_PUBLIC_IP` | `ec2_public_ip` | EC2 인스턴스의 퍼블릭 IP |
| `SSH_KEY` | `ssh_private_key_pem` | EC2 접속용 SSH Private Key |
| `AWS_ACCESS_KEY_ID` | `iam_access_key_id` | 배포용 IAM User Access Key |
| `AWS_SECRET_ACCESS_KEY` | `iam_secret_access_key` | 배포용 IAM User Secret Key |

## 📦 애플리케이션 배포 참고사항

- EC2 인스턴스 부팅 시 Docker와 Docker Compose가 자동으로 설치됩니다.
- 애플리케이션 배포 전, `docker-compose.yml`에 필요한 환경 변수(`DB_HOST`, `DB_NAME`, `DB_USERNAME`, `DB_PASSWORD`)가 EC2 내부에 설정되거나 배포 스크립트에 포함되어야 합니다.
- **R2 스트리밍**: 앱 코드에서 사용하는 Cloudflare R2 관련 환경 변수도 GitHub Secrets를 통해 관리하십시오.

---
*Managed by Terraform - Swiftly Infrastructure Team*
