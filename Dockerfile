# Eclipse Temurin JRE 21 - runtime only, no compiler (smaller image size)
FROM eclipse-temurin:21

# Set working directory inside the container
WORKDIR /app

# Copy the Minecraft server JAR and the entrypoint.sh into the container
COPY server.jar /app/
COPY entrypoint.sh /app/

# Accept the minecraft licence (EULA) and make entrypoint executable
RUN echo "eula=true" > /app/eula.txt
RUN chmod +x /app/entrypoint.sh

# Default minecraft port
EXPOSE 25565

# Start the minecraft server on container launch
ENTRYPOINT ["/app/entrypoint.sh"]