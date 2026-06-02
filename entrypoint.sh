#!/bin/bash
# Use Bash to run this script

# Generate server.properties from environment variables prefixed with MC_
printenv | grep "^MC_" | while IFS='=' read -r key value; do
  key=$(echo "$key" | sed 's/^MC_//' | tr '[:upper:]' '[:lower:]' | tr '_' '-')
  echo "$key=$value"
done > /data/server.properties

# Copy eula.txt to persistent data directory
cp /app/eula.txt /data/eula.txt

# Start Minecraft server from /data directory so all files are written there
cd /data && java -jar /app/server.jar --nogui