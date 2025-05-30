#!/bin/sh

# Set the threshold percentage (e.g., X%)
THRESHOLD=${THRESHOLD:-90}

# Disk to check (default: /)
DISK="/"

# Command to run (default: docker system prune -a -f)
COMMAND=${COMMAND:-"docker system prune -a -f"}

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
# Using directly with system cron
# sudo nano /etc/crontab
# */5 * * * * root /bin/bash /home/vaggeliskls/github-runner/check_disk_space.sh
# sudo systemctl restart cron
# grep check_disk_space /var/log/syslog