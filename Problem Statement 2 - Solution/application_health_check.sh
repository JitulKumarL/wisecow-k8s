#!/bin/bash
# Simple app health checker
# Works with HTTPS + self-signed certs

URL="https://wisecow.local"

# Try 3 times
for i in {1..3}
do
  # -k   = ignore SSL certificate checks (for self-signed certs)
  # -s   = silent mode
  # -o   = discard output
  # -w   = write only HTTP status code
  status=$(curl -k -s -o /dev/null -w "%{http_code}" $URL)

  if [ "$status" -eq 200 ]; then
    echo "App is UP (status $status)"
    exit 0
  else
    echo "Attempt $i: App returned status $status"
    sleep 2
  fi
done

echo "App seems DOWN after 3 attempts"
exit 1
