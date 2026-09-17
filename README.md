# Databricks Azure to AWS Migration Toolkit

> **Production-grade cross-cloud migration automation and Terraform infrastructure modules for migrating Databricks workspaces and Data Lakes from Microsoft Azure (ADLS Gen2) to Amazon Web Services (AWS Databricks + S3).**

![License](https://img.shields.io/badge/License-MIT-blue.svg)
![Terraform](https://img.shields.io/badge/Terraform-1.6+-844FBA.svg)
![AWS](https://img.shields.io/badge/AWS-Databricks-FF9900.svg)
![Azure](https://img.shields.io/badge/Azure-ADLS_Gen2-0078D4.svg)
![Python](https://img.shields.io/badge/Python-3.11+-3776AB.svg)

---

##  Overview

This toolkit provides an enterprise migration path with zero data loss and minimal cutover downtime for large-scale enterprise data ecosystems (e.g. Retail, Financial services).

### Key Capabilities
- **Automated Workspace Provisioning**: AWS Databricks E2 architecture deployed with modular Terraform.
- **Cross-Cloud Storage Sync**: S3 / ADLS Gen2 incremental metadata & data sync scripts with MD5 hash integrity verification.
- **IAM & Unity Catalog Governance**: Unified security mapping converting Azure Role-Based Access Control (RBAC) into AWS IAM and Unity Catalog policies.
- **FinOps Optimization**: Auto-scaling cluster policies with AWS Spot instances and Graviton processors to lower compute TCO by up to 35%.

---

##  Repository Structure

```
├── terraform/
│   ├── main.tf             # AWS Databricks Workspace & VPC setup
│   ├── variables.tf        # Configurable CIDRs, accounts, and regions
│   ├── outputs.tf          # Workspace URL and Data Lake S3 buckets
│   └── s3_datalake.tf      # S3 storage with KMS server-side encryption
├── scripts/
│   ├── data_lake_sync.py   # High-throughput cross-cloud sync utility
│   └── cutover_validator.py# Row-count and checksum validation engine
├── .github/
│   └── workflows/
│       └── migration-check.yml # CI validation for Terraform and Python
├── LICENSE
└── README.md
```

---

##  Getting Started

### 1. Prerequisites
- Terraform `>= 1.6`
- AWS CLI configured with administrator or DataOps IAM role
- Azure CLI with reader access to source ADLS Gen2 storage accounts
- Python 3.11+ with `boto3` and `azure-storage-blob`

### 2. Deploy AWS Databricks Infrastructure
```bash
cd terraform
terraform init
terraform plan -out=tfplan
terraform apply tfplan
```

### 3. Run Data Lake Verification
```bash
python scripts/cutover_validator.py \
  --azure-container "raw-sales" \
  --aws-bucket "riachuelo-datalake-prod-s3" \
  --threads 16
```

---

##  License
MIT License - Copyright (c) 2025-2026 Rennan Simões.
