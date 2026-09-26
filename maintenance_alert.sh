#!/bin/bash

CONFIG_FILE="config.conf"
LOG_FILE="maintenance_log.txt"

if [ ! -f "$CONFIG_FILE" ]; then
    echo "[ERROR] Configuration file not found: $CONFIG_FILE"
    exit 1
fi

source "$CONFIG_FILE"

echo "=========================================="
echo "   AIRCRAFT MAINTENANCE ALERT SYSTEM"
echo "=========================================="

echo ""

MEMORY_USED=$(free | awk '/Mem:/ {printf "%.0f", $3/$2 * 100}')
DISK_USED=$(df / | awk 'NR==2 {gsub("%",""); print $5}')

ALERT_FOUND=false

echo "Checking aircraft-related monitoring conditions..."
echo ""

if [ "$MEMORY_USED" -ge "$MEMORY_CRITICAL_THRESHOLD" ]; then
    echo "[CRITICAL] Fault Code: SYS-MEM-900"
    echo "Action: Investigate excessive memory utilization."
    ALERT_FOUND=true

elif [ "$MEMORY_USED" -ge "$MEMORY_WARNING_THRESHOLD" ]; then
    echo "[WARNING] Fault Code: SYS-MEM-800"
    echo "Action: Monitor memory utilization."
    ALERT_FOUND=true
fi

if [ "$DISK_USED" -ge "$DISK_CRITICAL_THRESHOLD" ]; then
    echo "[CRITICAL] Fault Code: SYS-DISK-900"
    echo "Action: Investigate critical storage utilization."
    ALERT_FOUND=true

elif [ "$DISK_USED" -ge "$DISK_WARNING_THRESHOLD" ]; then
    echo "[WARNING] Fault Code: SYS-DISK-800"
    echo "Action: Monitor storage utilization."
    ALERT_FOUND=true
fi

if [ "$ALERT_FOUND" = false ]; then
    echo "[NORMAL] No active maintenance alerts detected."
    echo "Maintenance Status: MONITORING"
fi

if [ "$ENABLE_MAINTENANCE_LOG" = true ] && [ "$ALERT_FOUND" = true ]; then

    {
        echo ""
        echo "------------------------------------"
        echo "MAINTENANCE ALERT"
        echo "------------------------------------"
        echo "Date: $(date)"
        echo "Memory Usage: $MEMORY_USED%"
        echo "Disk Usage: $DISK_USED%"
        echo "Action: Review diagnostic alert."
    } >> "$LOG_FILE"

    echo ""
    echo "Maintenance event recorded in: $LOG_FILE"
fi

echo ""
echo "Maintenance alert cycle: COMPLETE"
