#!/bin/bash

# Local Testing Script for StudyVerse Website
# Tests the website locally before deploying to AWS

echo "========================================="
echo "StudyVerse Local Testing"
echo "========================================="
echo ""

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
    echo "❌ Python3 not found. Install with: brew install python3"
    exit 1
fi

# Find available port
PORT=8000
while lsof -Pi :$PORT -sTCP:LISTEN -t >/dev/null 2>&1; do
    echo "Port $PORT is in use, trying next port..."
    ((PORT++))
done

echo -e "${BLUE}==>${NC} Starting local web server on port $PORT..."
echo ""

# Start Python HTTP server in background
python3 -m http.server $PORT --directory .. > /dev/null 2>&1 &
SERVER_PID=$!

# Wait for server to start
sleep 2

# Check if server started successfully
if ! ps -p $SERVER_PID > /dev/null; then
    echo "❌ Failed to start web server"
    exit 1
fi

echo -e "${GREEN}✅${NC} Web server started (PID: $SERVER_PID)"
echo ""
echo "========================================="
echo "Testing Website"
echo "========================================="
echo ""

# Test main page
echo -e "${BLUE}==>${NC} Testing main page..."
if curl -s -o /dev/null -w "%{http_code}" http://localhost:$PORT/courses.html | grep -q "200"; then
    echo -e "${GREEN}✅${NC} Main page accessible"
else
    echo "❌ Main page not accessible"
fi

# Test login page
echo -e "${BLUE}==>${NC} Testing login page..."
if curl -s -o /dev/null -w "%{http_code}" http://localhost:$PORT/login.html | grep -q "200"; then
    echo -e "${GREEN}✅${NC} Login page accessible"
else
    echo "❌ Login page not accessible"
fi

# Test admin dashboard
echo -e "${BLUE}==>${NC} Testing admin dashboard..."
if curl -s -o /dev/null -w "%{http_code}" http://localhost:$PORT/admin-dashboard.html | grep -q "200"; then
    echo -e "${GREEN}✅${NC} Admin dashboard accessible"
else
    echo "❌ Admin dashboard not accessible"
fi

# Test CSS files
echo -e "${BLUE}==>${NC} Testing CSS files..."
if curl -s -o /dev/null -w "%{http_code}" http://localhost:$PORT/style.css | grep -q "200"; then
    echo -e "${GREEN}✅${NC} CSS files accessible"
else
    echo "❌ CSS files not accessible"
fi

# Test JS files
echo -e "${BLUE}==>${NC} Testing JavaScript files..."
if curl -s -o /dev/null -w "%{http_code}" http://localhost:$PORT/script.js | grep -q "200"; then
    echo -e "${GREEN}✅${NC} JavaScript files accessible"
else
    echo "❌ JavaScript files not accessible"
fi

echo ""
echo "========================================="
echo "Local Testing Complete!"
echo "========================================="
echo ""
echo -e "${GREEN}✅${NC} Website is running at:"
echo "   http://localhost:$PORT/courses.html"
echo ""
echo "Open in browser:"
echo "   open http://localhost:$PORT/courses.html"
echo ""
echo "To stop the server:"
echo "   kill $SERVER_PID"
echo ""
echo "Press Ctrl+C to stop the server and exit"
echo ""

# Wait for user to stop
trap "echo ''; echo 'Stopping server...'; kill $SERVER_PID 2>/dev/null; echo 'Server stopped'; exit 0" INT

# Keep script running
wait $SERVER_PID
