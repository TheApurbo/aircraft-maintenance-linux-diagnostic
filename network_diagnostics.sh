#!/bin/bash

CONFIG_FILE="config.conf"

if [ ! -f "$CONFIG_FILE" ]; then
    echo "[ERROR] Configuration file not found: $CONFIG_FILE"
    exit 1
fi

source "$CONFIG_FILE"

echo "=========================================="
echo "   AIRCRAFT NETWORK DIAGNOSTIC MODULE"
echo "=========================================="

echo ""

if [ "$ENABLE_NETWORK_CHECK" != true ]; then
    echo "Network monitoring is disabled."
    exit 0
fi

echo "Network Interfaces"
echo "------------------"
ip -br addr

echo ""
echo "Default Route"
echo "-------------"
ip route | grep default || echo "[WARNING] No default route detected."

echo ""
echo "Connectivity Test"
echo "-----------------"

TARGET="1.1.1.1"

if ping -c 2 -W 2 "$TARGET" > /dev/null 2>&1; then
    echo "[NORMAL] Network connectivity is available."
else
    echo "[WARNING] Network connectivity test failed."
fi

echo ""
echo "DNS Resolution Test"
echo "-------------------"

if getent hosts example.com > /dev/null 2>&1; then
    echo "[NORMAL] DNS resolution is working."
else
    echo "[WARNING] DNS resolution test failed."
fi

echo ""
echo "Network diagnostic cycle: COMPLETE"
