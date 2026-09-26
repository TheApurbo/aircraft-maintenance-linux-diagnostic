#!/bin/bash

echo "=========================================="
echo "   AIRCRAFT LINUX DIAGNOSTIC SYSTEM"
echo "=========================================="

echo ""
echo "[1/5] Running Linux system monitor..."
echo "------------------------------------------"
bash aircraft-linux-monitor.sh

echo ""
echo "[2/5] Running network diagnostics..."
echo "------------------------------------------"
bash network_diagnostics.sh

echo ""
echo "[3/5] Running fault detection engine..."
echo "------------------------------------------"
bash fault_detection.sh

echo ""
echo "[4/5] Running maintenance alert system..."
echo "------------------------------------------"
bash maintenance_alert.sh

echo ""
echo "[5/5] Generating aircraft health report..."
echo "------------------------------------------"
bash generate_health_report.sh

echo ""
echo "=========================================="
echo "       DIAGNOSTIC WORKFLOW COMPLETE"
echo "=========================================="

echo ""
echo "Generated report: aircraft_health_report.txt"
echo "Maintenance log: maintenance_log.txt"

echo ""
echo "All diagnostic modules completed."
