#!/bin/bash

# Webhook Testing Script
# Tests the API Gateway endpoint to ensure it's responding correctly

set -e

# Color codes
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

if [ -z "$1" ]; then
    echo -e "${RED}Error: No webhook URL provided${NC}"
    echo "Usage: ./test-webhook.sh <webhook-url>"
    echo "Example: ./test-webhook.sh https://xxxxx.execute-api.region.amazonaws.com/trello"
    exit 1
fi

WEBHOOK_URL=$1

echo -e "${YELLOW}Testing webhook endpoint...${NC}"
echo "URL: $WEBHOOK_URL"
echo ""

# Test 1: GET request (webhook verification)
echo "Test 1: GET request (webhook verification)"
GET_RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" -X GET "$WEBHOOK_URL")

if [ "$GET_RESPONSE" = "200" ]; then
    echo -e "${GREEN}✓ GET request successful (Status: $GET_RESPONSE)${NC}"
else
    echo -e "${RED}✗ GET request failed (Status: $GET_RESPONSE)${NC}"
fi

echo ""

# Test 2: POST request with test payload
echo "Test 2: POST request with test payload"
POST_RESPONSE=$(curl -s -w "\nHTTP_STATUS:%{http_code}" -X POST \
  -H "Content-Type: application/json" \
  -d '{"test":"hello","action":{"type":"test"}}' \
  "$WEBHOOK_URL")

HTTP_STATUS=$(echo "$POST_RESPONSE" | grep "HTTP_STATUS:" | cut -d':' -f2)
BODY=$(echo "$POST_RESPONSE" | sed '/HTTP_STATUS:/d')

if [ "$HTTP_STATUS" = "200" ]; then
    echo -e "${GREEN}✓ POST request successful (Status: $HTTP_STATUS)${NC}"
    echo "Response: $BODY"
else
    echo -e "${RED}✗ POST request failed (Status: $HTTP_STATUS)${NC}"
    echo "Response: $BODY"
fi

echo ""
echo -e "${YELLOW}Testing complete!${NC}"
