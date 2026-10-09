#!/usr/bin/env bash
set -euo pipefail

# Змінні середовища з дефолтними значеннями вашого варіанта (Варіант 2: charlie, порт 8082)
HOST_PORT="${HOST_PORT:-8082}"
CONTAINER_SUFFIX="${CONTAINER_SUFFIX:-charlie}"
CONTAINER_NAME="devbox2-${CONTAINER_SUFFIX}"
IMAGE_NAME="ubuntu:24.04"

echo "=== Розгортання капсули $CONTAINER_NAME на порту $HOST_PORT ==="

# 1. Ідемпотентність: прибираємо старий контейнер, якщо він вже існує
docker rm -f "$CONTAINER_NAME" 2>/dev/null || true

# 2. Запуск нового контейнера з проброшеним портом у фоновому режимі (sleep infinity)
docker run -d \
  --name "$CONTAINER_NAME" \
  -p "${HOST_PORT}:80" \
  "$IMAGE_NAME" sleep infinity >/dev/null

# 3. Встановлення необхідних утиліт без інтерактивних запитань
echo "Встановлення утиліт (curl, git, procps, iproute2)..."
docker exec "$CONTAINER_NAME" bash -c '
  export DEBIAN_FRONTEND=noninteractive
  apt-get update -y >/dev/null && \
  apt-get install -y curl git procps iproute2 >/dev/null
'

echo "=== Капсула успішно розгорнута! ==="