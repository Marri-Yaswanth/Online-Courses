#!/bin/bash

# Nagios Setup Script for macOS
# Sets up Nagios monitoring for StudyVerse Online Courses website

set -e

echo "========================================="
echo "Nagios Setup for StudyVerse Website"
echo "========================================="
echo ""

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "❌ Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "✅ Homebrew found"
fi

# Install Nagios
echo ""
echo "Installing Nagios..."
if ! command -v nagios &> /dev/null; then
    brew install nagios
    echo "✅ Nagios installed"
else
    echo "✅ Nagios already installed"
fi

# Install Nagios Plugins
echo ""
echo "Installing Nagios Plugins..."
if ! brew list nagios-plugins &> /dev/null; then
    brew install nagios-plugins
    echo "✅ Nagios Plugins installed"
else
    echo "✅ Nagios Plugins already installed"
fi

# Create necessary directories
echo ""
echo "Creating Nagios directories..."
sudo mkdir -p /usr/local/var/log/nagios/archives
sudo mkdir -p /usr/local/var/nagios
sudo chown -R $(whoami) /usr/local/var/log/nagios
sudo chown -R $(whoami) /usr/local/var/nagios

# Copy configuration files
echo ""
echo "Setting up configuration..."
NAGIOS_ETC="/usr/local/etc/nagios"

# Backup existing config
if [ -f "$NAGIOS_ETC/nagios.cfg" ]; then
    sudo cp "$NAGIOS_ETC/nagios.cfg" "$NAGIOS_ETC/nagios.cfg.backup.$(date +%s)"
    echo "✅ Backed up existing configuration"
fi

# Copy custom website monitoring config
sudo cp objects/studyverse-website.cfg "$NAGIOS_ETC/objects/"
echo "✅ Copied website monitoring configuration"

# Update main nagios.cfg to include custom config
if ! grep -q "studyverse-website.cfg" "$NAGIOS_ETC/nagios.cfg"; then
    echo "cfg_file=$NAGIOS_ETC/objects/studyverse-website.cfg" | sudo tee -a "$NAGIOS_ETC/nagios.cfg" > /dev/null
    echo "✅ Updated main Nagios configuration"
fi

# Verify configuration
echo ""
echo "Verifying Nagios configuration..."
if sudo nagios -v "$NAGIOS_ETC/nagios.cfg"; then
    echo "✅ Configuration verified successfully"
else
    echo "❌ Configuration verification failed"
    exit 1
fi

# Start Nagios
echo ""
echo "Starting Nagios..."
brew services start nagios
sleep 3

# Check if Nagios is running
if brew services list | grep nagios | grep started > /dev/null; then
    echo "✅ Nagios is running"
else
    echo "❌ Failed to start Nagios"
    exit 1
fi

echo ""
echo "========================================="
echo "✅ NAGIOS SETUP COMPLETE!"
echo "========================================="
echo ""
echo "Access Nagios at: http://localhost:8080/nagios"
echo "Default credentials:"
echo "  Username: nagiosadmin"
echo "  Password: (set during installation)"
echo ""
echo "To update website URL after deployment:"
echo "  1. Edit: $NAGIOS_ETC/objects/studyverse-website.cfg"
echo "  2. Replace 'address' with your actual S3 website URL"
echo "  3. Restart: brew services restart nagios"
echo ""
echo "Useful commands:"
echo "  Status:  brew services list"
echo "  Restart: brew services restart nagios"
echo "  Stop:    brew services stop nagios"
echo "  Logs:    tail -f /usr/local/var/log/nagios/nagios.log"
