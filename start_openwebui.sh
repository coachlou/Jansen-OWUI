#!/bin/bash

echo "Stopping and removing existing open-webui container..."
docker stop open-webui && docker rm open-webui

echo "Starting open-webui container with community sharing disabled..."
# docker run -d -p 3000:8080 -e ENABLE_COMMUNITY_SHARING=false --add-host=host.docker.internal:host-gateway   -e OLLAMA_BASE_URL=http://127.0.0.1:11434 -v open-webui:/app/backend/data --name open-webui --restart always ghcr.io/open-webui/open-webui:main
docker compose -f docker-compose.mac-ollama.yaml up -d 
if [ $? -ne 0 ]; then
    echo "Failed to start the Open WebUI container."
    exit 1
fi

echo "Open WebUI container started."
