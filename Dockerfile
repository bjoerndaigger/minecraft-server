# Java runtime image
FROM eclipse-temurin:25-jre

# Set working directory inside the container
WORKDIR /app

# Install curl and download the Minecraft server JAR
RUN apt-get update && apt-get install -y curl \
       && rm -rf /var/lib/apt/lists/* \
       && curl -o server.jar -L "https://piston-data.mojang.com/v1/objects/97ccd4c0ed3f81bbb7bfacddd1090b0c56f9bc51/server.jar"

# Copy entrypoint script and accept the Minecraft licence
COPY entrypoint.sh /app/
RUN echo "eula=true" > /app/eula.txt
RUN chmod +x /app/entrypoint.sh

# Default minecraft port
EXPOSE 25565

# Start the minecraft server on container launch
ENTRYPOINT ["/app/entrypoint.sh"]