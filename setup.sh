#!/bin/bash

# StudyVerse Project Setup Script
# Sets up the project with the new organized structure

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 StudyVerse Project Setup${NC}"
echo "=================================="

# Check if we're in the right directory
if [ ! -f "PROJECT_STRUCTURE.md" ]; then
    echo -e "${RED}❌ Please run this script from the project root directory${NC}"
    exit 1
fi

echo -e "${YELLOW}📁 Verifying project structure...${NC}"

# Check required directories
REQUIRED_DIRS=(
    "src"
    "src/css"
    "src/js"
    "src/assets"
    "infrastructure/terraform"
    "infrastructure/ansible"
    "infrastructure/nagios"
    "deployment/scripts"
    "deployment/docker"
    "docs"
    "tests"
)

for dir in "${REQUIRED_DIRS[@]}"; do
    if [ -d "$dir" ]; then
        echo -e "${GREEN}✅ $dir${NC}"
    else
        echo -e "${RED}❌ $dir (missing)${NC}"
        mkdir -p "$dir"
        echo -e "${YELLOW}📁 Created $dir${NC}"
    fi
done

echo -e "\n${YELLOW}🔧 Setting up permissions...${NC}"

# Make scripts executable
find deployment/scripts -name "*.sh" -exec chmod +x {} \; 2>/dev/null || true
find infrastructure/nagios -name "*.sh" -exec chmod +x {} \; 2>/dev/null || true
find tests -name "*.sh" -exec chmod +x {} \; 2>/dev/null || true

echo -e "${GREEN}✅ Scripts made executable${NC}"

echo -e "\n${YELLOW}📋 Checking prerequisites...${NC}"

# Check for required tools
TOOLS=("aws" "terraform" "ansible" "git" "docker")
MISSING_TOOLS=()

for tool in "${TOOLS[@]}"; do
    if command -v "$tool" &> /dev/null; then
        echo -e "${GREEN}✅ $tool installed${NC}"
    else
        echo -e "${RED}❌ $tool not found${NC}"
        MISSING_TOOLS+=("$tool")
    fi
done

if [ ${#MISSING_TOOLS[@]} -gt 0 ]; then
    echo -e "\n${YELLOW}📦 Missing tools detected. Install them using:${NC}"
    echo -e "${BLUE}macOS (Homebrew):${NC}"
    echo "brew install ${MISSING_TOOLS[*]}"
    echo -e "${BLUE}Windows (Chocolatey):${NC}"
    echo "choco install ${MISSING_TOOLS[*]} -y"
    echo -e "${BLUE}Linux (apt):${NC}"
    echo "sudo apt install ${MISSING_TOOLS[*]} -y"
fi

echo -e "\n${YELLOW}🔍 Project status:${NC}"

# Check AWS configuration
if aws sts get-caller-identity &>/dev/null; then
    echo -e "${GREEN}✅ AWS CLI configured${NC}"
else
    echo -e "${RED}❌ AWS CLI not configured${NC}"
    echo -e "${YELLOW}💡 Run: aws configure${NC}"
fi

# Check Terraform state
if [ -f "infrastructure/terraform/terraform.tfstate" ]; then
    echo -e "${GREEN}✅ Terraform state exists${NC}"
else
    echo -e "${YELLOW}⚠️  Terraform not initialized${NC}"
    echo -e "${YELLOW}💡 Run: cd infrastructure/terraform && terraform init${NC}"
fi

# Check if website files exist
if [ -f "src/courses.html" ] && [ -f "src/login.html" ]; then
    echo -e "${GREEN}✅ Website files present${NC}"
else
    echo -e "${RED}❌ Website files missing${NC}"
fi

echo -e "\n${GREEN}🎉 Setup complete!${NC}"
echo -e "\n${BLUE}📚 Next steps:${NC}"
echo "1. Configure AWS: aws configure"
echo "2. Initialize Terraform: cd infrastructure/terraform && terraform init"
echo "3. Deploy infrastructure: terraform apply"
echo "4. Deploy website: cd ../../deployment/scripts && ./sync-to-s3.sh"
echo "5. Setup monitoring: cd ../../infrastructure/nagios && ./setup-nagios-mac.sh"

echo -e "\n${BLUE}📖 Documentation:${NC}"
echo "• Project Structure: PROJECT_STRUCTURE.md"
echo "• Setup Guide: docs/DEVOPS_SETUP_GUIDE.md"
echo "• Quick Start: docs/QUICK_START.md"

echo -e "\n${YELLOW}🌐 After deployment, your website will be available at:${NC}"
echo "http://studyverse-online-courses-prod-382ecd8a.s3-website-us-east-1.amazonaws.com/"