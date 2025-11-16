#!/bin/bash

# Prerequisites Checker for StudyVerse DevOps Project
# Checks if all required tools are installed and configured

echo "========================================="
echo "StudyVerse DevOps Prerequisites Checker"
echo "========================================="
echo ""

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

ERRORS=0
WARNINGS=0

# Function to check command
check_command() {
    if command -v $1 &> /dev/null; then
        echo -e "${GREEN}✅${NC} $1 is installed"
        if [ ! -z "$2" ]; then
            VERSION=$($1 $2 2>&1 | head -n 1)
            echo "   Version: $VERSION"
        fi
        return 0
    else
        echo -e "${RED}❌${NC} $1 is NOT installed"
        echo "   Install with: $3"
        ((ERRORS++))
        return 1
    fi
}

# Check Homebrew
echo "Checking Homebrew..."
check_command "brew" "--version" "/bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
echo ""

# Check AWS CLI
echo "Checking AWS CLI..."
if check_command "aws" "--version" "brew install awscli"; then
    # Check AWS credentials
    echo "   Checking AWS credentials..."
    if aws sts get-caller-identity &> /dev/null; then
        echo -e "   ${GREEN}✅${NC} AWS credentials configured"
        ACCOUNT=$(aws sts get-caller-identity --query Account --output text)
        echo "   Account: $ACCOUNT"
    else
        echo -e "   ${RED}❌${NC} AWS credentials NOT configured"
        echo "   Run: aws configure"
        ((ERRORS++))
    fi
fi
echo ""

# Check Ansible
echo "Checking Ansible..."
check_command "ansible" "--version" "brew install ansible"
echo ""

# Check Terraform (optional)
echo "Checking Terraform (optional)..."
if check_command "terraform" "--version" "brew install terraform"; then
    echo "   Terraform is optional but recommended"
else
    echo -e "   ${YELLOW}⚠️${NC}  Terraform is optional for this project"
    ((WARNINGS++))
fi
echo ""

# Check Docker (optional)
echo "Checking Docker (optional)..."
if check_command "docker" "--version" "brew install --cask docker"; then
    # Check if Docker daemon is running
    if docker ps &> /dev/null; then
        echo -e "   ${GREEN}✅${NC} Docker daemon is running"
    else
        echo -e "   ${YELLOW}⚠️${NC}  Docker is installed but daemon not running"
        echo "   Start Docker Desktop application"
        ((WARNINGS++))
    fi
else
    echo -e "   ${YELLOW}⚠️${NC}  Docker is optional for local testing"
    ((WARNINGS++))
fi
echo ""

# Check Nagios (optional)
echo "Checking Nagios (optional)..."
if check_command "nagios" "-V" "brew install nagios"; then
    # Check if Nagios is running
    if brew services list | grep nagios | grep started &> /dev/null; then
        echo -e "   ${GREEN}✅${NC} Nagios service is running"
    else
        echo -e "   ${YELLOW}⚠️${NC}  Nagios is installed but not running"
        echo "   Start with: brew services start nagios"
        ((WARNINGS++))
    fi
else
    echo -e "   ${YELLOW}⚠️${NC}  Nagios is optional for monitoring"
    ((WARNINGS++))
fi
echo ""

# Check Python (for local testing)
echo "Checking Python (for local testing)..."
check_command "python3" "--version" "brew install python3"
echo ""

# Summary
echo "========================================="
echo "Summary"
echo "========================================="
echo ""

if [ $ERRORS -eq 0 ]; then
    echo -e "${GREEN}✅ All required tools are installed!${NC}"
    echo ""
    echo "You're ready to deploy:"
    echo "  cd ansible"
    echo "  ansible-playbook playbooks/ansible-only-deploy.yml"
else
    echo -e "${RED}❌ $ERRORS required tool(s) missing${NC}"
    echo ""
    echo "Please install missing tools before proceeding."
fi

if [ $WARNINGS -gt 0 ]; then
    echo ""
    echo -e "${YELLOW}⚠️  $WARNINGS optional tool(s) not configured${NC}"
    echo "These are optional but recommended for full functionality."
fi

echo ""
echo "========================================="

exit $ERRORS
