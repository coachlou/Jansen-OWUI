# My Open WebUI Notes

## Database Storage Locations

### Docker Volume Persistence
The databases are persisted in Docker volumes on the host filesystem:

**Open WebUI Database:**
- **Docker Volume**: `open-webui` 
- **Container Path**: `/app/backend/data`
- **Host Path**: `/var/lib/docker/volumes/open-webui/_data`
- **Contains**: SQLite databases, user data, configurations, uploaded files

**Ollama Data:**
- **Docker Volume**: `ollama`
- **Container Path**: `/root/.ollama` 
- **Host Path**: `/var/lib/docker/volumes/ollama/_data`
- **Contains**: Downloaded models, model configurations

### macOS Specific Notes
Since Docker runs in a Linux VM on macOS, the actual files are stored in:
- **Docker Desktop VM**: `~/Library/Containers/com.docker.docker/Data/vms/0/data/docker/volumes/`

### Accessing Database Files

**View volume information:**
```bash
docker volume ls
docker volume inspect open-webui
docker volume inspect ollama
```

**Access via Docker container (recommended):**
```bash
# List database files
docker exec open-webui ls -la /app/backend/data/

# Access SQLite database directly
docker exec -it open-webui sqlite3 /app/backend/data/webui.db

# Find all .db files
docker exec -it open-webui find /app/backend/data -name "*.db"
```

**Copy files out:**
```bash
# Copy specific database
docker cp open-webui:/app/backend/data/webui.db ./webui.db

# Copy entire data directory
docker cp open-webui:/app/backend/data/ ./open-webui-data/
```

**Use Docker Desktop GUI:**
- Open Docker Desktop
- Go to Volumes tab
- Browse the `open-webui` and `ollama` volumes

### Data Persistence Notes
- Database files persist between container restarts
- Data survives `docker-compose down` commands
- Data would be lost with `docker-compose down -v` (removes volumes)
- Main Open WebUI database is typically named `webui.db`

----

