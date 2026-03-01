#!/bin/bash
# ============================================================
# scripts/deploy.sh  — Automated deploy for any environment
# Usage: ./scripts/deploy.sh <dev|staging|prod> <plan|apply|destroy>
# ============================================================

set -euo pipefail

ENV=${1:-dev}
ACTION=${2:-plan}
TFVARS="envs/${ENV}/terraform.tfvars"
ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

# Colour output
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'

log()   { echo -e "${GREEN}[deploy]${NC} $1"; }
warn()  { echo -e "${YELLOW}[warn]${NC}  $1"; }
error() { echo -e "${RED}[error]${NC} $1"; exit 1; }

# Validate
[[ "$ENV" =~ ^(dev|staging|prod)$ ]]    || error "env must be: dev | staging | prod"
[[ "$ACTION" =~ ^(plan|apply|destroy)$ ]] || error "action must be: plan | apply | destroy"
[[ -f "$ROOT_DIR/$TFVARS" ]]            || error "tfvars not found: $TFVARS"

cd "$ROOT_DIR"

log "Initialising Terraform..."
terraform init -upgrade

log "Validating configuration..."
terraform validate

log "Formatting check..."
terraform fmt -check -recursive || warn "Some files need formatting — run: terraform fmt -recursive"

log "Running: terraform ${ACTION} for environment: ${ENV}"

case "$ACTION" in
  plan)
    terraform plan -var-file="$TFVARS" -out="${ENV}.tfplan"
    log "Plan saved to ${ENV}.tfplan"
    ;;
  apply)
    if [[ "$ENV" == "prod" ]]; then
      warn "⚠️  You are about to apply changes to PRODUCTION!"
      read -rp "Type 'yes' to confirm: " confirm
      [[ "$confirm" == "yes" ]] || error "Aborted by user."
    fi
    terraform apply -var-file="$TFVARS" -auto-approve
    log "✅ Apply complete for ${ENV}"
    terraform output
    ;;
  destroy)
    warn "⚠️  This will DESTROY all resources in ${ENV}!"
    read -rp "Type 'yes' to confirm: " confirm
    [[ "$confirm" == "yes" ]] || error "Aborted by user."
    terraform destroy -var-file="$TFVARS" -auto-approve
    log "✅ Destroy complete for ${ENV}"
    ;;
esac
