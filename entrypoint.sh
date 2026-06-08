#!/bin/bash
# Use Bash to run this script

# Generate server.properties from template using environment variables
envsubst < /app/server.properties.template > /data/server.properties

# Copy eula.txt to persistent data directory
cp /app/eula.txt /data/eula.txt

# Start Minecraft server from /data directory so all files are written there
cd /data && java -jar /app/server.jar --nogui