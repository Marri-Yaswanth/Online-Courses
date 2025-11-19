#!/bin/bash

# Nagios Port Forwarding Script
# Forward local port 8080 to remote Nagios (port 80)

REMOTE_HOST="your-server-ip"
REMOTE_USER="ubuntu"
LOCAL_PORT="8080"
REMOTE_PORT="80"

echo "Starting port forwarding..."
echo "Local: http://localhost:${LOCAL_PORT}"
echo "Remote: ${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_PORT}"
echo "Press Ctrl+C to stop"

ssh -L ${LOCAL_PORT}:localhost:${REMOTE_PORT} ${REMOTE_USER}@${REMOTE_HOST}