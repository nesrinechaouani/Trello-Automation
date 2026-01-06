#!/bin/bash

# Lambda Deployment Script
# Packages and deploys the Lambda function to AWS

set -e

# Color codes
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

FUNCTION_NAME="trelloWebhookHandler"
REGION="eu-west-1"

echo -e "${YELLOW}Starting deployment process...${NC}"

# Step 1: Create deployment package
echo ""
echo "Step 1: Creating deployment package"
cd src

# Install dependencies
echo "Installing dependencies..."
pip install -r requirements.txt -t . --upgrade

# Create zip file
echo "Creating zip file..."
zip -r ../function.zip . -x "*.pyc" -x "__pycache__/*" -x "*.git/*"

cd ..

echo -e "${GREEN}✓ Deployment package created: function.zip${NC}"

# Step 2: Deploy to AWS Lambda
echo ""
echo "Step 2: Deploying to AWS Lambda"

if [ -z "$AWS_PROFILE" ]; then
    AWS_CMD="aws"
else
    AWS_CMD="aws --profile $AWS_PROFILE"
fi

echo "Function: $FUNCTION_NAME"
echo "Region: $REGION"

DEPLOY_OUTPUT=$($AWS_CMD lambda update-function-code \
    --function-name "$FUNCTION_NAME" \
    --zip-file fileb://function.zip \
    --region "$REGION" 2>&1)

if echo "$DEPLOY_OUTPUT" | grep -q "FunctionName"; then
    echo -e "${GREEN}✓ Lambda function deployed successfully!${NC}"
    
    # Extract and display version
    VERSION=$(echo "$DEPLOY_OUTPUT" | grep -o '"Version":"[^"]*"' | cut -d'"' -f4)
    echo "Version: $VERSION"
    
    # Get function URL
    FUNCTION_URL=$($AWS_CMD lambda get-function-url-config \
        --function-name "$FUNCTION_NAME" \
        --region "$REGION" 2>/dev/null | grep -o '"FunctionUrl":"[^"]*"' | cut -d'"' -f4 || echo "No function URL configured")
    
    if [ "$FUNCTION_URL" != "No function URL configured" ]; then
        echo "Function URL: $FUNCTION_URL"
    fi
else
    echo -e "${RED}✗ Deployment failed${NC}"
    echo "$DEPLOY_OUTPUT"
    exit 1
fi

# Clean up
echo ""
echo "Cleaning up..."
rm function.zip

echo ""
echo -e "${GREEN}Deployment complete!${NC}"
echo ""
echo "Next steps:"
echo "1. Verify environment variables are set in Lambda"
echo "2. Test the API Gateway endpoint"
echo "3. Register the Trello webhook"
