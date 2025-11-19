#!/bin/bash

# StudyVerse S3 Sync Script
# Syncs website files to both S3 buckets

set -e

# Configuration
WEBSITE_DIR="../../src"  # Source directory contains website files
BUCKET_1="studyverse-online-courses-prod-382ecd8a"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}StudyVerse S3 Sync Script${NC}"
echo "=================================="

# Check if website directory exists
if [ ! -d "$WEBSITE_DIR" ]; then
    echo -e "${RED}Error: Website directory '$WEBSITE_DIR' not found${NC}"
    echo "Please update WEBSITE_DIR in this script or create the directory"
    exit 1
fi

# Check AWS CLI
if ! command -v aws &> /dev/null; then
    echo -e "${RED}Error: AWS CLI not installed${NC}"
    exit 1
fi

# Check AWS credentials
if ! aws sts get-caller-identity &> /dev/null; then
    echo -e "${RED}Error: AWS credentials not configured${NC}"
    echo "Run: aws configure"
    exit 1
fi

echo -e "${YELLOW}Syncing to Production Bucket...${NC}"
aws s3 sync "$WEBSITE_DIR" "s3://$BUCKET_1" \
    --delete \
    --exclude "*.DS_Store" \
    --exclude "*.git/*" \
    --exclude "node_modules/*" \
    --cache-control "max-age=86400"

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Production bucket sync completed${NC}"
else
    echo -e "${RED}✗ Production bucket sync failed${NC}"
    exit 1
fi

echo -e "${GREEN}Sync completed successfully!${NC}"
echo ""
echo "Website URLs:"
echo "🌐 Main Site: http://$BUCKET_1.s3-website-us-east-1.amazonaws.com/"
echo "🔐 Login Page: http://$BUCKET_1.s3-website-us-east-1.amazonaws.com/login.html"
echo "👨‍💼 Admin Dashboard: http://$BUCKET_1.s3-website-us-east-1.amazonaws.com/admin-dashboard.html"
echo ""
echo -e "${YELLOW}Tip: Use './scripts/s3-dry-run.sh . $BUCKET_1' to preview changes before syncing${NC}"