# Minecraft Server

A reproducible, configurable Minecraft Java Edition server running in Docker using a custom image. Configuration is managed via environment variables, world data persists in a Docker volume and the server starts with a single command.

## Table of Contents

- [Quickstart](#quickstart)
- [Usage](#usage)
  - [Start the Server](#start-the-server)
  - [Configuration](#configuration)
  - [Adding More Variables](#adding-more-variables)
  - [Data Persistence](#data-persistence)
- [Testing](#testing)
- [Notes](#notes)

## Quickstart

### Prerequisites

- Docker & Docker Compose installed
- Python 3.x installed (for testing)

Run the following commands to start the server:

```bash
cp .env.template .env
docker compose up --build -d
```

> **Note:** By starting the server, you accept the [Minecraft End User License Agreement (EULA)](https://www.minecraft.net/en-us/eula). Review it before use.

## Usage

### Start the Server

```bash
# Copy the environment template and adjust if needed
cp .env.template .env

# Build and start the server in the foreground
docker compose up --build

# Build and start the server in the background
docker compose up --build -d

# Stop the server
docker compose down
```

### Configuration

Environment variables are configured via a `.env` file in the root of the repository.

Create a `.env` file before starting the server:

```env
DIFFICULTY=normal
```

Available options for `DIFFICULTY`: `peaceful`, `easy`, `normal`, `hard`

### Adding More Variables

To extend the configuration, add new variables to `entrypoint.sh`:

```bash
echo "max-players=${MAX_PLAYERS:-20}" >> /app/server.properties
```

`>>` appends the property to the existing file instead of overwriting it.

Then add the variable to your `.env` file:

```env
DIFFICULTY=normal
MAX_PLAYERS=20
```

### Data Persistence

World data and server files are stored in a Docker volume (`local_data`). The volume survives container restarts and `docker compose down`.

To fully reset the server and delete all world data:

```bash
docker compose down --volumes
```

## Testing

The test suite uses [mcstatus](https://github.com/py-mine/mcstatus) to verify that the server is reachable. Make sure the server is running before executing the commands below.

Create and activate a virtual environment:

```bash
python -m venv .venv

# macOS/Linux
source .venv/bin/activate

# Windows
.venv\Scripts\activate
```

Install dependencies (includes `mcstatus`):

```bash
pip install -r requirements.txt
```

Check server status:

```bash
# Full status (version, players, ping)
mcstatus localhost:8888 status

# Latency only
mcstatus localhost:8888 ping
```

## Notes

- The server listens on container port `25565`, mapped to host port `8888`.