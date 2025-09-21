#!/bin/bash
# Simple system health check script
# Checks CPU, memory, and disk usage and prints alerts

CPU_THRESHOLD=80
MEM_THRESHOLD=80
DISK_THRESHOLD=80

while true
do
  # CPU usage
  cpu=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}' | cut -d. -f1)
  echo "CPU Usage: $cpu%"
  if [ "$cpu" -gt "$CPU_THRESHOLD" ]; then
    echo "Warning: High CPU usage detected- $cpu%"
  fi

  # Memory usage
  mem=$(free | grep Mem | awk '{print $3/$2 * 100.0}' | cut -d. -f1)
  echo "Memory Usage: $mem%"
  if [ "$mem" -gt "$MEM_THRESHOLD" ]; then
    echo "Warning: High Memory usage detected- $mem%"
  fi

  # Disk usage
  disk=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
  echo "Disk Usage: $disk%"
  if [ "$disk" -gt "$DISK_THRESHOLD" ]; then
    echo "Warning: High Disk usage detected- $disk%"
  fi

  echo "----"
  sleep 10   # wait before next check
done
