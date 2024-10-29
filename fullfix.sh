#!/bin/bash

# Function to log messages
log() {
    echo "[INFO] $(date '+%Y-%m-%d %H:%M:%S') - $1"
}

# Function to remove chattr attributes
remove_chattr() {
    if lsattr /var/spool/cron/crontabs/root | grep -q "i"; then
        log "Removing chattr attributes from /var/spool/cron/crontabs/root..."
        if ! chattr -ia -e /var/spool/cron/crontabs/root; then
            log "Failed to remove chattr attributes."
        fi
    fi
}

# Function to clean cron jobs
clean_cron_jobs() {
    log "Removing specific cron jobs..."
    if crontab -l | grep -q "*/3 * * * * /usr/lib/secure/atdb"; then
        (crontab -l | grep -v "*/3 * * * * /usr/lib/secure/atdb") | crontab -
        log "Removed unwanted cron job."
    else
        log "No matching cron jobs found."
    fi
}

# Function to kill processes
kill_processes() {
    local processes=("kdevtmpfsi" "kinsing" "udisksd" "[kworker/1:0-events]")
    for process in "${processes[@]}"; do
        log "Killing process: $process"
        if pkill -9 "$process"; then
            log "Killed all processes for $process"
        else
            log "No running process found for $process"
        fi
    done
}

# Function to clean up files
clean_up_files() {
    log "Removing files for kdevtmpfsi and kinsing..."
    find / -iname "kdevtmpfsi" -o -iname "kinsing" -exec rm -fv {} \; 2>/dev/null

    log "Cleaning temporary files..."
    rm -rf /tmp/kdevtmpfsi /var/tmp/kdevtmpfsi /tmp/kinsing /var/tmp/kinsing
}

# Function to create and protect temporary files
create_protected_files() {
    log "Creating and protecting temporary files..."
    for file in "/tmp/kdevtmpfsi" "/var/tmp/kdevtmpfsi" "/var/tmp/kinsing" "/tmp/kinsing"; do
        touch "$file" || { log "Failed to create $file"; continue; }
        echo "$file is fine now" > "$file"
        if ! chattr +i "$file"; then
            log "Failed to set immutable attribute on $file"
        fi
    done
}

# Main script execution
log "Starting cleanup script..."
remove_chattr
clean_cron_jobs
clean_up_files
kill_processes
create_protected_files
log "Cleanup completed successfully."
