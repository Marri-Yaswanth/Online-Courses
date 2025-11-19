#!/bin/bash

# S3 Sync Dry Run - Preview changes without actually syncing
# Usage: ./s3-dry-run.sh <local-directory> <bucket-name>

set -e

if [ $# -ne 2 ]; then
    echo "Usage: $0 <local-directory> <bucket-name>"
    echo "Example: $0 ../website studyverse-online-courses-1763288761"
    exit 1
fi

LOCAL_DIR="$1"
BUCKET_NAME="$2"

# Colors
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}DRY RUN: Preview of changes for s3://$BUCKET_NAME${NC}"
echo "========================================================"

aws s3 sync "$LOCAL_DIR" "s3://$BUCKET_NAME" \
    --dryrun \
    --delete \
    --exclude "*.DS_Store" \
    --exclude "*.git/*" \
    --exclude "node_modules/*"

echo ""
echo -e "${YELLOW}This was a dry run. No files were actually changed.${NC}"
echo "To perform the actual sync, run:"
echo "./sync-specific-bucket.sh $BUCKET_NAME $LOCAL_DIR"