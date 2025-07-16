#!/bin/bash

echo "Stopping and removing existing open-webui container..."
docker stop open-webui && docker rm open-webui

echo "Starting open-webui container with community sharing disabled..."
docker run -d -p 3000:8080 -e ENABLE_COMMUNITY_SHARING=false --add-host=host.docker.internal:host-gateway -v open-webui:/app/backend/data --name open-webui --restart always ghcr.io/open-webui/open-webui:main

echo "Open WebUI container started."
