#!/bin/bash

echo "======================================"
echo "   AIRCRAFT LINUX SYSTEM MONITOR"
echo "======================================"

echo ""
echo "System Information"
echo "------------------"
echo "Hostname: $(hostname)"
echo "Kernel: $(uname -r)"
echo "OS: $(. /etc/os-release && echo "$PRETTY_NAME")"

echo ""
echo "CPU Usage"
echo "---------"
top -bn1 | grep "Cpu(s)" | head -1

echo ""
echo "Memory Usage"
echo "------------"
free -h

echo ""
echo "Disk Usage"
echo "----------"
df -h /

echo ""
echo "Network Status"
echo "--------------"
ip -br addr

echo ""
echo "Aircraft Maintenance Monitoring"
echo "--------------------------------"
echo "Linux environment check completed."
echo "Status: READY"
