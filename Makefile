# Load environment variables from .env file
ifneq (,$(wildcard ./.env))
    include .env
    export
endif

.PHONY: init plan apply destroy

init:
	@echo "Initializing Terraform with Cloudflare R2 backend..."
	terraform init \
		-backend-config="endpoints={s3=\"https://$${CLOUDFLARE_ACCOUNT_ID}.r2.cloudflarestorage.com\"}" \
		-backend-config="bucket=$${R2_BUCKET_NAME}" \
		-backend-config="key=terraform.tfstate" \
		-backend-config="region=auto" \
		-backend-config="access_key=$${R2_ACCESS_KEY_ID}" \
		-backend-config="secret_key=$${R2_SECRET_ACCESS_KEY}" \
		-backend-config="skip_credentials_validation=true" \
		-backend-config="skip_region_validation=true" \
		-backend-config="skip_requesting_account_id=true" \
		-backend-config="skip_metadata_api_check=true" \
		-backend-config="skip_s3_checksum=true" \
		-backend-config="use_path_style=true"

plan:
	terraform plan -var="admin_ip=$(shell curl -s http://checkip.amazonaws.com)/32"

apply:
	terraform apply -var="admin_ip=$(shell curl -s http://checkip.amazonaws.com)/32"

destroy:
	terraform destroy -var="admin_ip=$(shell curl -s http://checkip.amazonaws.com)/32"
