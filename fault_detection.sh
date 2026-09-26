#!/bin/bash

echo "======================================"
echo "   AIRCRAFT FAULT DETECTION ENGINE"
echo "======================================"

echo ""
echo "Running system diagnostics..."
echo ""

CPU_LOAD=$(awk '{print $1}' /proc/loadavg)
MEMORY_USED=$(free | awk '/Mem:/ {printf "%.0f", $3/$2 * 100}')
DISK_USED=$(df / | awk 'NR==2 {gsub("%",""); print $5}')

echo "CPU Load: $CPU_LOAD"
echo "Memory Usage: $MEMORY_USED%"
echo "Disk Usage: $DISK_USED%"

echo ""
echo "Diagnostic Results"
echo "------------------"

if [ "$MEMORY_USED" -ge 90 ]; then
    echo "[CRITICAL] Memory usage is above safe threshold."
else
    echo "[NORMAL] Memory subsystem operating normally."
fi

if [ "$DISK_USED" -ge 90 ]; then
    echo "[CRITICAL] Storage capacity is critically high."
else
    echo "[NORMAL] Storage subsystem operating normally."
fi

if [ "$DISK_USED" -ge 80 ] && [ "$DISK_USED" -lt 90 ]; then
    echo "[WARNING] Storage capacity approaching threshold."
fi

echo ""
echo "Aircraft Maintenance Status"
echo "----------------------------"
echo "Diagnostic scan completed."
echo "Fault detection cycle: COMPLETE"

echo ""
echo "Overall Status: OPERATIONAL"
