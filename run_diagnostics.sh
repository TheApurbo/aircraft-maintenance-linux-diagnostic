#!/bin/bash

echo "=========================================="
echo "   AIRCRAFT LINUX DIAGNOSTIC SYSTEM"
echo "=========================================="

echo ""
echo "[1/4] Running Linux system monitor..."
echo "------------------------------------------"
bash aircraft-linux-monitor.sh

echo ""
echo "[2/4] Running network diagnostics..."
echo "------------------------------------------"
bash network_diagnostics.sh

echo ""
echo "[3/4] Running fault detection engine..."
echo "------------------------------------------"
bash fault_detection.sh

echo ""
echo "[4/4] Generating aircraft health report..."
echo "------------------------------------------"
bash generate_health_report.sh

echo ""
echo "=========================================="
echo "       DIAGNOSTIC WORKFLOW COMPLETE"
echo "=========================================="

echo ""
echo "Health report: aircraft_health_report.txt"
echo "System status: DIAGNOSTIC CYCLE COMPLETE"
