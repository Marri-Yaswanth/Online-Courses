variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name for resource naming"
  type        = string
  default     = "studyverse-online-courses"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "prod"
}

variable "existing_bucket_name" {
  description = "Existing bucket name to import (leave empty to create new)"
  type        = string
  default     = ""
}


