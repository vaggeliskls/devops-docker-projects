#!/bin/sh

# Set the threshold percentage (e.g., X%)
THRESHOLD=${THRESHOLD:-95}

# Disk to check (default: /)
DISK="/"

# Webhook URL (optional)
WEBHOOK_URL=${WEBHOOK_URL:-""}

EXTRA_MESSAGE=${EXTRA_MESSAGE:-""}

# Get the current date and time
DATE_TIME=$(date "+%Y-%m-%d %H:%M:%S")

# Get the current disk usage percentage
USAGE=$(df -h "$DISK" | awk 'NR==2 {print $5}' | sed 's/%//')

# Check if usage exceeds threshold
if [ "$USAGE" -ge "$THRESHOLD" ]; then
    MESSAGE="🟥 [${DATE_TIME}] Warning: Disk usage is at ${USAGE}%, exceeding the threshold of ${THRESHOLD}% on ${DISK} disk. ${EXTRA_MESSAGE}"
    echo "$MESSAGE"
    
    # Send the notification to Microsoft Teams
    if [ -n "$WEBHOOK_URL" ]; then
        curl -H "Content-Type: application/json" -X POST -d "{\"text\": \"${MESSAGE}\"}" "$WEBHOOK_URL"
    fi
    
    # Running command
    if [ -n "$COMMAND" ]; then
        eval "$COMMAND"
    fi
else
    echo "🟩 [${DATE_TIME}] Disk usage is at $USAGE%, below threshold ($THRESHOLD%)"
fi