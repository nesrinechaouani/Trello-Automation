variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "eu-west-1"
}

variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
  default     = "trelloWebhookHandler"
}

variable "lambda_zip_path" {
  description = "Path to the Lambda deployment package"
  type        = string
  default     = "../function.zip"
}

variable "mongo_uri" {
  description = "MongoDB connection URI"
  type        = string
  sensitive   = true
}

variable "mongo_db" {
  description = "MongoDB database name"
  type        = string
  default     = "lookinglass03"
}

variable "mongo_collection" {
  description = "MongoDB collection name"
  type        = string
  default     = "archived_cards"
}

variable "log_retention_days" {
  description = "CloudWatch log retention in days"
  type        = number
  default     = 7
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    Project     = "trello-mongodb-archiver"
    ManagedBy   = "Terraform"
    Environment = "production"
  }
}
