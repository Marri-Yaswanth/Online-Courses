#!/bin/bash

# Quick Demo Script for StudyVerse Online Courses DevOps Project
# This script demonstrates the complete deployment and monitoring workflow

set -e

echo "========================================="
echo "StudyVerse DevOps Demo"
echo "========================================="
echo ""

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_step() {
    echo -e "${BLUE}==>${NC} $1"
}

print_success() {
    echo -e "${GREEN}✅${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠️${NC} $1"
}

# Check prerequisites
print_step "Checking prerequisites..."

if ! command -v aws &> /dev/null; then
    echo "❌ AWS CLI not found. Install with: brew install awscli"
    exit 1
fi
print_success "AWS CLI found"

if ! command -v ansible &> /dev/null; then
    echo "❌ Ansible not found. Install with: brew install ansible"
    exit 1
fi
print_success "Ansible found"

# Check AWS credentials
print_step "Verifying AWS credentials..."
if ! aws sts get-caller-identity &> /dev/null; then
    echo "❌ AWS credentials not configured. Run: aws configure"
    exit 1
fi
print_success "AWS credentials verified"

echo ""
echo "========================================="
echo "Phase 1: Deploy Website with Ansible"
echo "========================================="
echo ""

cd ansible
print_step "Deploying website to AWS S3..."
ansible-playbook playbooks/ansible-only-deploy.yml

print_success "Website deployed successfully!"

echo ""
echo "========================================="
echo "Phase 2: Verify Deployment"
echo "========================================="
echo ""

print_step "Verifying website accessibility..."
sleep 5  # Wait for S3 to propagate
ansible-playbook playbooks/verify-deployment.yml

print_success "Website verified and accessible!"

echo ""
echo "========================================="
echo "Phase 3: Monitoring Setup"
echo "========================================="
echo ""

print_warning "Nagios monitoring requires manual setup"
print_step "To setup monitoring:"
echo "  1. cd nagios"
echo "  2. ./setup-nagios-mac.sh"
echo "  3. ./update-monitoring-url.sh YOUR_WEBSITE_URL"
echo "  4. Open http://localhost:8080/nagios"

echo ""
echo "========================================="
echo "Demo Complete!"
echo "========================================="
echo ""
print_success "Your website is now live on AWS!"
echo ""
echo "Deployment info saved to: ansible/deployment-info.txt"
echo ""
print_warning "Don't forget to cleanup resources when done:"
echo "  cd ansible"
echo "  ansible-playbook playbooks/ansible-cleanup.yml"
echo ""
