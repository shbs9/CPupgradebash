#!/bin/bash

# Function to log messages
log() {
    echo "[INFO] $(date '+%Y-%m-%d %H:%M:%S') - $1"
}

# Kill all processes with the name "udiskssd"
kill_udiskssd_processes() {
    local process_name="udiskssd"
    log "Searching for $process_name processes..."

    # Find all PIDs matching the process name
    pids=$(pgrep "$process_name")
    
    if [ -n "$pids" ]; then
        log "Killing $process_name processes..."
        for pid in $pids; do
            kill -9 "$pid" && log "Killed process $pid ($process_name)"
        done
    else
        log "No running process found for $process_name"
    fi
}

# Main execution
log "Starting udiskssd process cleanup..."
kill_udiskssd_processes
log "udiskssd process cleanup completed."
