#!/bin/bash
# Use Bash to run this script

# Create server.properties if it doesn't exist
if [ ! -f /app/server.properties ]; then
  # Set difficulty, default to "normal" if DIFFICULTY is unset
  echo "difficulty=${DIFFICULTY:-normal}" > /app/server.properties
fi

# Start Minecraft server
java -jar /app/server.jar