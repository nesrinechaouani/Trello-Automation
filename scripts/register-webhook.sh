#!/bin/bash

# Trello Webhook Registration Script
# This script registers a webhook with Trello to monitor card archival events

set -e

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if required environment variables are set
if [ -z "$TRELLO_API_KEY" ]; then
    echo -e "${RED}Error: TRELLO_API_KEY is not set${NC}"
    echo "Get your API key from: https://trello.com/app-key"
    exit 1
fi

if [ -z "$TRELLO_TOKEN" ]; then
    echo -e "${RED}Error: TRELLO_TOKEN is not set${NC}"
    echo "Generate a token from: https://trello.com/app-key"
    exit 1
fi

if [ -z "$TRELLO_BOARD_ID" ]; then
    echo -e "${RED}Error: TRELLO_BOARD_ID is not set${NC}"
    echo "You can find the board ID in the board URL"
    exit 1
fi

if [ -z "$WEBHOOK_CALLBACK_URL" ]; then
    echo -e "${RED}Error: WEBHOOK_CALLBACK_URL is not set${NC}"
    echo "This should be your API Gateway URL"
    exit 1
fi

echo -e "${YELLOW}Registering Trello webhook...${NC}"
echo "Board ID: $TRELLO_BOARD_ID"
echo "Callback URL: $WEBHOOK_CALLBACK_URL"

RESPONSE=$(curl -s -X POST "https://api.trello.com/1/webhooks/?key=${TRELLO_API_KEY}&token=${TRELLO_TOKEN}" \
  -d "callbackURL=${WEBHOOK_CALLBACK_URL}" \
  -d "idModel=${TRELLO_BOARD_ID}" \
  -d "description=Archive cards to MongoDB" \
  -d "active=true")

if echo "$RESPONSE" | grep -q '"id"'; then
    WEBHOOK_ID=$(echo "$RESPONSE" | grep -o '"id":"[^"]*"' | cut -d'"' -f4)
    echo -e "${GREEN}✓ Webhook registered successfully!${NC}"
    echo "Webhook ID: $WEBHOOK_ID"
    echo ""
    echo "To delete this webhook later, run:"
    echo "curl -X DELETE \"https://api.trello.com/1/webhooks/${WEBHOOK_ID}?key=${TRELLO_API_KEY}&token=${TRELLO_TOKEN}\""
else
    echo -e "${RED}✗ Failed to register webhook${NC}"
    echo "Response: $RESPONSE"
    exit 1
fi
