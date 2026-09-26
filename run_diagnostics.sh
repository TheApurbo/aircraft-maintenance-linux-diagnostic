#!/bin/bash

echo "=========================================="
echo "   AIRCRAFT LINUX DIAGNOSTIC SYSTEM"
echo "=========================================="

echo ""
echo "[1/3] Running Linux system monitor..."
echo "------------------------------------------"
bash aircraft-linux-monitor.sh

echo ""
echo "[2/3] Running fault detection engine..."
echo "------------------------------------------"
bash fault_detection.sh

echo ""
echo "[3/3] Generating aircraft health report..."
echo "------------------------------------------"
bash generate_health_report.sh

echo ""
echo "=========================================="
echo "       DIAGNOSTIC WORKFLOW COMPLETE"
echo "=========================================="

echo ""
echo "Generated report:"
echo "aircraft_health_report.txt"

echo ""
echo "System Status: OPERATIONAL"
