#!/usr/bin/env bash
set -euo pipefail
export HOST_PORT="${HOST_PORT:-8082}"
export CONTAINER_SUFFIX="${CONTAINER_SUFFIX:-charlie}"

echo "Розгортання капсули із суфіксом '$CONTAINER_SUFFIX' на порту $HOST_PORT..."