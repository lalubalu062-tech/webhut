#!/bin/bash

# 1. Start DBus
mkdir -p /var/run/dbus
dbus-daemon --system --fork

# 2. Fix XRDP for Docker and start it forcefully
echo "Starting XRDP..."
mkdir -p /var/run/xrdp
chown xrdp:xrdp /var/run/xrdp
/usr/sbin/xrdp-sesman
/usr/sbin/xrdp

# 3. UptimeRobot ke liye Dummy Web Server
cd /tmp && python3 -m http.server 10000 &

# 4. Bore Tunnel Start
echo "Starting Bore tunnel for RDP..."
bore local 3389 --to bore.pub
