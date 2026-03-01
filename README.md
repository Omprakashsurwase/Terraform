# AWS Infrastructure — Fully Automated Terraform Template

One template. Any service. Minimal changes.

---

## 📁 Folder Structure

```
aws-infra/
├── main.tf                   # Root orchestrator — wires all modules
├── variables.tf              # All variable declarations
├── outputs.tf                # All outputs
│
├── modules/
│   ├── vpc/                  # VPC, subnets, IGW, NAT, route tables
│   ├── security-groups/      # Bastion, App, DB security groups
│   ├── ec2/                  # EC2 instances + optional EIP
│   ├── rds/                  # RDS (Postgres/MySQL) + subnet group
│   ├── s3/                   # S3 bucket with encryption + lifecycle
│   └── ecs/                  # ECS Fargate cluster + service + task
│
├── envs/
│   ├── dev/terraform.tfvars
│   ├── staging/terraform.tfvars
│   └── prod/terraform.tfvars
│
└── scripts/
    └── deploy.sh             # Automated deploy for any environment
```

---

## 🚀 To Add or Enable Any Service

**Only ONE change needed in your `.tfvars` file:**

```hcl
# Want EC2? Just flip this:
ec2_enabled = true

# Want RDS? Just flip this:
rds_enabled = true

# Want S3? Just flip this:
s3_enabled = true

# Want ECS? Just flip this:
ecs_enabled = true
```

That's it. No changes to `main.tf`, no new files, no rewiring.

---

## 🛠️ Quick Start

### 1. Prerequisites
- Terraform >= 1.5.0
- AWS CLI configured (`aws configure`)

### 2. Bootstrap remote state (once)
```bash
aws s3 mb s3://your-tf-state-bucket --region us-east-1
aws dynamodb create-table \
  --table-name terraform-state-lock \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST
```
Then update the `backend "s3"` block in `main.tf`.

### 3. Deploy an environment
```bash
chmod +x scripts/deploy.sh

# Plan (dry run)
./scripts/deploy.sh dev plan

# Apply
./scripts/deploy.sh dev apply

# Destroy
./scripts/deploy.sh dev destroy
```

### 4. Manual commands
```bash
terraform init
terraform plan  -var-file="envs/dev/terraform.tfvars"
terraform apply -var-file="envs/dev/terraform.tfvars"
```

---

## ➕ Adding a Brand New Service (e.g. ElastiCache)

Follow this 4-step pattern:

**Step 1** — Create `modules/elasticache/` with `main.tf`, `variables.tf`, `outputs.tf`

**Step 2** — Add a module block in `main.tf`:
```hcl
module "elasticache" {
  source = "./modules/elasticache"
  count  = var.elasticache_enabled ? 1 : 0
  # pass vars...
}
```

**Step 3** — Add variables in `variables.tf`:
```hcl
variable "elasticache_enabled" { type = bool; default = false }
variable "elasticache_node_type" { type = string; default = "cache.t3.micro" }
```

**Step 4** — Add outputs in `outputs.tf` and flip the flag in your `.tfvars`:
```hcl
elasticache_enabled = true
```

---

## 🌍 Environments

| Environment | VPC CIDR    | Instance Size | Multi-AZ RDS | Notes                     |
|-------------|-------------|---------------|--------------|---------------------------|
| dev         | 10.0.0.0/16 | t3.micro      | No           | Cost-minimal, open SSH    |
| staging     | 10.1.0.0/16 | t3.small      | No           | Production-like config    |
| prod        | 10.2.0.0/16 | t3.medium+    | Yes          | HA, restricted access     |

---

## 🔐 Security Notes

- All EBS volumes are encrypted by default
- IMDSv2 enforced on all EC2 instances
- S3 buckets block all public access
- RDS uses encrypted `gp3` storage
- DB only accessible from app security group
- **Never commit `rds_password` — use AWS SSM Parameter Store or Secrets Manager in prod**
