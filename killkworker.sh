#!/bin/bash

# Set CPU usage threshold
THRESHOLD=80

# Monitor kworker processes in a loop
while true; do
    # Get list of kworker processes consuming more than the threshold
    ps -e -o pid,comm,pcpu --no-headers | awk -v threshold=$THRESHOLD '$2 ~ /^kworker/ && $3 > threshold {print $1, $3}' | while read pid cpu_usage; do
        echo "Killing kworker process with PID $pid, CPU usage: $cpu_usage%"
        kill -9 $pid
    done

    # Sleep for a few seconds before checking again
    sleep 5
done
