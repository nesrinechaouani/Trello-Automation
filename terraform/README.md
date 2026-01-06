# Terraform Infrastructure

This directory contains Terraform configurations to deploy the complete infrastructure for the Trello MongoDB archiver.

## What Gets Deployed

- AWS Lambda function with IAM role
- API Gateway HTTP API with route and integration
- CloudWatch Log Groups for Lambda and API Gateway
- CloudWatch alarms for monitoring
- Lambda permissions for API Gateway invocation

## Prerequisites

1. [Terraform](https://www.terraform.io/downloads) installed (>= 1.0)
2. AWS CLI configured with appropriate credentials
3. Lambda deployment package created (`function.zip`)

## Quick Start

### 1. Create Deployment Package

```bash
# From project root
cd src
pip install -r requirements.txt -t .
zip -r ../function.zip .
cd ..
```

### 2. Configure Variables

Create a `terraform.tfvars` file:

```hcl
aws_region     = "eu-west-1"
function_name  = "trelloWebhookHandler"
mongo_uri      = "mongodb+srv://user:pass@cluster.mongodb.net/"
mongo_db       = "lookinglass03"
mongo_collection = "archived_cards"
```

**Important**: Never commit `terraform.tfvars` with sensitive data!

### 3. Initialize Terraform

```bash
cd terraform
terraform init
```

### 4. Plan Deployment

```bash
terraform plan
```

Review the planned changes.

### 5. Apply Configuration

```bash
terraform apply
```

Type `yes` to confirm.

### 6. Get Outputs

```bash
terraform output
```

This will show:
- Lambda function ARN and name
- API Gateway URL
- Webhook callback URL (use this for Trello)
- CloudWatch log group names

## Using the Webhook URL

After deployment, register the webhook with Trello:

```bash
# Get the webhook URL
WEBHOOK_URL=$(terraform output -raw webhook_callback_url)

# Register with Trello
curl -X POST "https://api.trello.com/1/webhooks/?key=YOUR_KEY&token=YOUR_TOKEN" \
  -d "callbackURL=${WEBHOOK_URL}" \
  -d "idModel=YOUR_BOARD_ID" \
  -d "description=Archive cards to MongoDB" \
  -d "active=true"
```

## Managing Infrastructure

### View Current State

```bash
terraform show
```

### Update Infrastructure

1. Modify `.tf` files as needed
2. Run `terraform plan` to preview changes
3. Run `terraform apply` to apply changes

### Destroy Infrastructure

```bash
terraform destroy
```

**Warning**: This will delete all resources!

## Updating Lambda Code

When you update the Lambda function code:

```bash
# From project root
cd src
pip install -r requirements.txt -t . --upgrade
zip -r ../function.zip .
cd ../terraform

# Terraform will detect the changed zip file
terraform apply
```

## Variables Reference

| Variable | Description | Required | Default |
|----------|-------------|----------|---------|
| `aws_region` | AWS region | No | `eu-west-1` |
| `function_name` | Lambda function name | No | `trelloWebhookHandler` |
| `lambda_zip_path` | Path to deployment package | No | `../function.zip` |
| `mongo_uri` | MongoDB connection string | Yes | - |
| `mongo_db` | Database name | No | `lookinglass03` |
| `mongo_collection` | Collection name | No | `archived_cards` |
| `log_retention_days` | CloudWatch log retention | No | `7` |
| `tags` | Resource tags | No | See variables.tf |

## Outputs Reference

| Output | Description |
|--------|-------------|
| `lambda_function_arn` | ARN of Lambda function |
| `lambda_function_name` | Name of Lambda function |
| `api_gateway_url` | Base API Gateway URL |
| `webhook_callback_url` | Full webhook URL for Trello |
| `cloudwatch_log_group` | Lambda log group name |

## Monitoring

### CloudWatch Alarms

Two alarms are automatically created:

1. **Lambda Errors**: Triggers when more than 5 errors occur in 5 minutes
2. **Lambda Throttles**: Triggers on any throttling

Configure SNS topics to receive notifications:

```hcl
# Add to main.tf
resource "aws_sns_topic" "alerts" {
  name = "trello-webhook-alerts"
}

# Then reference in alarm:
alarm_actions = [aws_sns_topic.alerts.arn]
```

### View Logs

```bash
# Get log group name
LOG_GROUP=$(terraform output -raw cloudwatch_log_group)

# View recent logs
aws logs tail "$LOG_GROUP" --follow
```

## State Management

### Remote State (Recommended for Production)

Configure S3 backend for state storage:

```hcl
# backend.tf
terraform {
  backend "s3" {
    bucket         = "your-terraform-state-bucket"
    key            = "trello-webhook/terraform.tfstate"
    region         = "eu-west-1"
    encrypt        = true
    dynamodb_table = "terraform-locks"
  }
}
```

### State Locking

Use DynamoDB for state locking:

```bash
# Create DynamoDB table
aws dynamodb create-table \
  --table-name terraform-locks \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST
```

## Security Best Practices

1. **Secrets Management**: Use AWS Secrets Manager for MongoDB URI
2. **State Encryption**: Enable encryption for Terraform state
3. **IAM Policies**: Follow principle of least privilege
4. **Network Security**: Consider VPC configuration for Lambda
5. **API Security**: Add API key authentication in production

## Troubleshooting

### Error: "No such file or directory: function.zip"

Create the deployment package first:
```bash
cd src && pip install -r requirements.txt -t . && zip -r ../function.zip . && cd ..
```

### Error: "Error creating Lambda function"

Check that:
- IAM role has correct permissions
- Function name is unique in the region
- Deployment package is valid

### Changes Not Applied

Force replacement:
```bash
terraform taint aws_lambda_function.webhook_handler
terraform apply
```

## Cost Estimation

Approximate monthly costs (AWS Free Tier):

- Lambda: Free tier includes 1M requests and 400,000 GB-seconds
- API Gateway: $1.00 per million requests after free tier
- CloudWatch Logs: $0.50 per GB ingested

Estimated cost for moderate use: **< $5/month**

## Additional Resources

- [Terraform AWS Provider Docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [AWS Lambda Pricing](https://aws.amazon.com/lambda/pricing/)
- [API Gateway Pricing](https://aws.amazon.com/api-gateway/pricing/)
