#!/bin/bash

# Security Audit Script for Cron Job Management

# Set variables
CRONTAB_FILE="/var/spool/cron/crontabs/root"
PATTERN="*/3 * * * * /usr/lib/secure/atdb"

# Check if the script is running as root
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root."
  exit 1
fi

# Step 1: List attributes of the crontab file
echo "Listing attributes of $CRONTAB_FILE:"
lsattr "$CRONTAB_FILE"

# Step 2: Change the attributes of the crontab file
echo "Removing immutable or append-only attributes from $CRONTAB_FILE..."
chattr -ia "$CRONTAB_FILE"
if [[ $? -ne 0 ]]; then
  echo "Failed to change attributes on $CRONTAB_FILE."
  exit 1
fi

# Step 3: Comment out the specified lines in the crontab file
echo "Commenting out lines matching the pattern: $PATTERN"
sed -i.bak "/$PATTERN/s/^/# /" "$CRONTAB_FILE"
if [[ $? -eq 0 ]]; then
  echo "Successfully commented out the lines."
else
  echo "Failed to comment out lines in $CRONTAB_FILE."
  exit 1
fi

echo "Script completed successfully."
