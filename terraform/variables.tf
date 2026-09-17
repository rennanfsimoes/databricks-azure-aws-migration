variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "AWS Region for target Databricks workspace"
}

variable "environment" {
  type        = string
  default     = "prod"
  description = "Deployment environment"
}

variable "project_name" {
  type        = string
  default     = "riachuelo-analytics"
  description = "Project name identifier"
}

variable "databricks_account_id" {
  type        = string
  default     = "00000000-0000-0000-0000-000000000000"
  description = "Databricks E2 Account ID"
}
