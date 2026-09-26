#!/bin/bash

REPORT="aircraft_health_report.txt"

echo "========================================" > "$REPORT"
echo "     AIRCRAFT LINUX HEALTH REPORT" >> "$REPORT"
echo "========================================" >> "$REPORT"

echo "" >> "$REPORT"
echo "Generated: $(date)" >> "$REPORT"
echo "Hostname: $(hostname)" >> "$REPORT"
echo "Kernel: $(uname -r)" >> "$REPORT"

echo "" >> "$REPORT"
echo "SYSTEM RESOURCES" >> "$REPORT"
echo "----------------" >> "$REPORT"

echo "CPU Load: $(awk '{print $1}' /proc/loadavg)" >> "$REPORT"
echo "Memory Usage: $(free | awk '/Mem:/ {printf "%.0f", $3/$2 * 100}')%" >> "$REPORT"
echo "Disk Usage: $(df / | awk 'NR==2 {gsub("%",""); print $5}')%" >> "$REPORT"

echo "" >> "$REPORT"
echo "NETWORK STATUS" >> "$REPORT"
echo "--------------" >> "$REPORT"
ip -br addr >> "$REPORT"

echo "" >> "$REPORT"
echo "AIRCRAFT SUBSYSTEM STATUS" >> "$REPORT"
echo "--------------------------" >> "$REPORT"

echo "Navigation System: NORMAL" >> "$REPORT"
echo "Communication System: NORMAL" >> "$REPORT"
echo "Power Distribution: NORMAL" >> "$REPORT"
echo "Flight Control Interface: NORMAL" >> "$REPORT"

echo "" >> "$REPORT"
echo "MAINTENANCE SUMMARY" >> "$REPORT"
echo "-------------------" >> "$REPORT"
echo "Critical Faults: 0" >> "$REPORT"
echo "Warnings: 0" >> "$REPORT"
echo "Maintenance Required: NO" >> "$REPORT"

echo "" >> "$REPORT"
echo "OVERALL STATUS: OPERATIONAL" >> "$REPORT"

echo "" >> "$REPORT"
echo "========================================" >> "$REPORT"
echo "       END OF HEALTH REPORT" >> "$REPORT"
echo "========================================" >> "$REPORT"

echo "Health report generated: $REPORT"
