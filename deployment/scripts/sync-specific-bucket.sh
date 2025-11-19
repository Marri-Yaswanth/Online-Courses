#!/bin/bash

# Sync to specific S3 bucket
# Usage: ./sync-specific-bucket.sh <bucket-name> <local-directory>

set -e

if [ $# -ne 2 ]; then
    echo "Usage: $0 <bucket-name> <local-directory>"
    echo "Example: $0 studyverse-online-courses-1763288761 ../website"
    exit 1
fi

BUCKET_NAME="$1"
LOCAL_DIR="$2"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${YELLOW}Syncing $LOCAL_DIR to s3://$BUCKET_NAME${NC}"

# Check if directory exists
if [ ! -d "$LOCAL_DIR" ]; then
    echo -e "${RED}Error: Directory '$LOCAL_DIR' not found${NC}"
    exit 1
fi

# Perform sync
aws s3 sync "$LOCAL_DIR" "s3://$BUCKET_NAME" \
    --delete \
    --exclude "*.DS_Store" \
    --exclude "*.git/*" \
    --exclude "node_modules/*" \
    --exclude "*.tmp" \
    --cache-control "max-age=86400" \
    --metadata-directive REPLACE

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Sync completed successfully${NC}"
    echo "URL: http://$BUCKET_NAME.s3-website-us-east-1.amazonaws.com"
else
    echo -e "${RED}✗ Sync failed${NC}"
    exit 1
fi