# Minecraft Server

A reproducible, configurable Minecraft Java Edition server running in Docker using a custom image. Configuration is managed via environment variables, world data persists in a Docker volume and the server starts with a single command.

## Table of Contents

- [Quickstart](#quickstart)
- [Usage](#usage)
  - [Configuration](#configuration)
  - [Data Persistence](#data-persistence)
- [Testing](#testing)
- [Notes](#notes)

## Quickstart

### Prerequisites

- Docker & Docker Compose installed
- Python 3.10+ installed (for testing)

Run the following commands to start the server:

```bash
cp .env.template .env
docker compose up --build -d
```

Stop the server:

```bash
docker compose down
```

> [!NOTE]  
> By starting the server, you accept the [Minecraft End User License Agreement (EULA)](https://www.minecraft.net/en-us/eula). Review it before use.

## Usage

### Configuration

Environment variables are configured via a `.env` file in the root of the repository.
All variables prefixed with `MC_` are automatically converted into entries in `server.properties`.

To add a new server setting, use the format `MC_<SETTING>=<VALUE>`, for example:

```env
MC_MAX_PLAYERS=20
```

For a complete list of available server properties, see:
https://minecraft.wiki/w/Server.properties

### Data Persistence

World data and server files are stored in a Docker volume (`local_data`) mounted at `/data`. The volume survives container restarts and `docker compose down`.

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