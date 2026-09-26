#!/bin/bash

CONFIG_FILE="config.conf"
REPORT="aircraft_health_report.txt"

if [ ! -f "$CONFIG_FILE" ]; then
    echo "[ERROR] Configuration file not found: $CONFIG_FILE"
    exit 1
fi

source "$CONFIG_FILE"

MEMORY_USED=$(free | awk '/Mem:/ {printf "%.0f", $3/$2 * 100}')
DISK_USED=$(df / | awk 'NR==2 {gsub("%",""); print $5}')
CPU_LOAD=$(awk '{print $1}' /proc/loadavg)

if [ "$MEMORY_USED" -ge "$MEMORY_CRITICAL_THRESHOLD" ]; then
    MEMORY_STATUS="CRITICAL"
elif [ "$MEMORY_USED" -ge "$MEMORY_WARNING_THRESHOLD" ]; then
    MEMORY_STATUS="WARNING"
else
    MEMORY_STATUS="NORMAL"
fi

if [ "$DISK_USED" -ge "$DISK_CRITICAL_THRESHOLD" ]; then
    DISK_STATUS="CRITICAL"
elif [ "$DISK_USED" -ge "$DISK_WARNING_THRESHOLD" ]; then
    DISK_STATUS="WARNING"
else
    DISK_STATUS="NORMAL"
fi

if ping -c 2 -W 2 1.1.1.1 > /dev/null 2>&1; then
    NETWORK_STATUS="NORMAL"
else
    NETWORK_STATUS="WARNING"
fi

CRITICAL_FAULTS=0
WARNINGS=0

if [ "$MEMORY_STATUS" = "CRITICAL" ]; then
    ((CRITICAL_FAULTS++))
elif [ "$MEMORY_STATUS" = "WARNING" ]; then
    ((WARNINGS++))
fi

if [ "$DISK_STATUS" = "CRITICAL" ]; then
    ((CRITICAL_FAULTS++))
elif [ "$DISK_STATUS" = "WARNING" ]; then
    ((WARNINGS++))
fi

if [ "$NETWORK_STATUS" = "WARNING" ]; then
    ((WARNINGS++))
fi

if [ "$CRITICAL_FAULTS" -gt 0 ]; then
    OVERALL_STATUS="CRITICAL"
elif [ "$WARNINGS" -gt 0 ]; then
    OVERALL_STATUS="WARNING"
else
    OVERALL_STATUS="OPERATIONAL"
fi

cat > "$REPORT" <<EOF
========================================
     AIRCRAFT LINUX HEALTH REPORT
========================================

Generated: $(date)
Hostname: $(hostname)
Kernel: $(uname -r)
Operating System: $(. /etc/os-release && echo "$PRETTY_NAME")

----------------------------------------
SYSTEM RESOURCE STATUS
----------------------------------------

CPU Load: $CPU_LOAD

Memory Usage: $MEMORY_USED%
Memory Status: $MEMORY_STATUS

Disk Usage: $DISK_USED%
Disk Status: $DISK_STATUS

----------------------------------------
NETWORK STATUS
----------------------------------------

Network Connectivity: $NETWORK_STATUS

----------------------------------------
AIRCRAFT SUBSYSTEM STATUS
----------------------------------------

Navigation System: $NAVIGATION_STATUS
Communication System: $COMMUNICATION_STATUS
Power Distribution: $POWER_DISTRIBUTION_STATUS
Flight Control Interface: $FLIGHT_CONTROL_STATUS

----------------------------------------
MAINTENANCE SUMMARY
----------------------------------------

Critical Faults: $CRITICAL_FAULTS
Warnings: $WARNINGS
Maintenance Logging: $ENABLE_MAINTENANCE_LOG

----------------------------------------
OVERALL SYSTEM STATUS
----------------------------------------

$OVERALL_STATUS

========================================
       END OF HEALTH REPORT
========================================
EOF

echo "Health report generated successfully."
echo "Report file: $REPORT"
echo "Overall Status: $OVERALL_STATUS"
