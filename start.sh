#!/bin/bash

# 1. Start DBus
mkdir -p /var/run/dbus
dbus-daemon --system --fork

# 2. Start XRDP service
/etc/init.d/xrdp start

# 3. UptimeRobot aur Render ko khush rakhne ke liye ek dummy Web Server chalayein (Port 10000 par)
cd /tmp && python3 -m http.server 10000 &

# 4. Bore Tunnel start karein jo local RDP (port 3389) ko public karega
echo "Starting Bore tunnel for RDP..."
bore local 3389 --to bore.pub

