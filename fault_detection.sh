#!/bin/bash

CONFIG_FILE="config.conf"

if [ ! -f "$CONFIG_FILE" ]; then
    echo "[ERROR] Configuration file not found: $CONFIG_FILE"
    exit 1
fi

source "$CONFIG_FILE"

echo "======================================"
echo "   AIRCRAFT FAULT DETECTION ENGINE"
echo "======================================"

echo ""
echo "Running system diagnostics..."
echo ""

MEMORY_USED=$(free | awk '/Mem:/ {printf "%.0f", $3/$2 * 100}')
DISK_USED=$(df / | awk 'NR==2 {gsub("%",""); print $5}')

echo "Memory Usage: $MEMORY_USED%"
echo "Disk Usage: $DISK_USED%"

echo ""
echo "Diagnostic Results"
echo "------------------"

if [ "$MEMORY_USED" -ge "$MEMORY_CRITICAL_THRESHOLD" ]; then
    echo "[CRITICAL] Memory usage exceeded critical threshold."
elif [ "$MEMORY_USED" -ge "$MEMORY_WARNING_THRESHOLD" ]; then
    echo "[WARNING] Memory usage approaching critical threshold."
else
    echo "[NORMAL] Memory subsystem operating normally."
fi

if [ "$DISK_USED" -ge "$DISK_CRITICAL_THRESHOLD" ]; then
    echo "[CRITICAL] Disk usage exceeded critical threshold."
elif [ "$DISK_USED" -ge "$DISK_WARNING_THRESHOLD" ]; then
    echo "[WARNING] Disk usage approaching critical threshold."
else
    echo "[NORMAL] Storage subsystem operating normally."
fi

echo ""
echo "Aircraft Subsystem Status"
echo "-------------------------"

echo "Navigation System: $NAVIGATION_STATUS"
echo "Communication System: $COMMUNICATION_STATUS"
echo "Power Distribution: $POWER_DISTRIBUTION_STATUS"
echo "Flight Control Interface: $FLIGHT_CONTROL_STATUS"

echo ""
echo "Maintenance Monitoring"
echo "----------------------"

if [ "$ENABLE_MAINTENANCE_LOG" = true ]; then
    echo "Maintenance logging: ENABLED"
else
    echo "Maintenance logging: DISABLED"
fi

if [ "$ENABLE_NETWORK_CHECK" = true ]; then
    echo "Network monitoring: ENABLED"
else
    echo "Network monitoring: DISABLED"
fi

echo ""
echo "Fault detection cycle: COMPLETE"
echo "Overall Diagnostic Status: COMPLETE"
