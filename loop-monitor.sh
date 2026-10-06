#!/usr/bin/env bash

LOG_FILE="/tmp/monitor.log"

stop_monitor() {
    echo "Monitor stopped at: $(date)" >> "$LOG_FILE"
    exit 0
}

trap stop_monitor SIGTERM SIGINT

while true; do
    echo "System time: $(date)" >> "$LOG_FILE"
    sleep 5
done
