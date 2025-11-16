#!/bin/bash

# Script to update Nagios monitoring with actual deployed website URL

if [ -z "$1" ]; then
    echo "Usage: $0 <website-url>"
    echo "Example: $0 studyverse-online-courses-1234567890.s3-website-us-east-1.amazonaws.com"
    exit 1
fi

WEBSITE_URL="$1"
NAGIOS_CONFIG="/usr/local/etc/nagios/objects/studyverse-website.cfg"

echo "Updating Nagios monitoring configuration..."
echo "New URL: $WEBSITE_URL"

# Backup current config
sudo cp "$NAGIOS_CONFIG" "$NAGIOS_CONFIG.backup.$(date +%s)"

# Update the address in the config file
sudo sed -i '' "s|address.*|address                 $WEBSITE_URL|g" "$NAGIOS_CONFIG"

# Update all check_http commands
sudo sed -i '' "s|-H [^ ]*|-H $WEBSITE_URL|g" "$NAGIOS_CONFIG"

# Verify configuration
echo ""
echo "Verifying configuration..."
if sudo nagios -v /usr/local/etc/nagios/nagios.cfg; then
    echo "✅ Configuration valid"
    
    # Restart Nagios
    echo ""
    echo "Restarting Nagios..."
    brew services restart nagios
    sleep 2
    
    echo ""
    echo "✅ Nagios updated and restarted successfully!"
    echo "Check monitoring at: http://localhost:8080/nagios"
else
    echo "❌ Configuration error. Restoring backup..."
    sudo cp "$NAGIOS_CONFIG.backup" "$NAGIOS_CONFIG"
    exit 1
fi
