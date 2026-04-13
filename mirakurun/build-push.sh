#!/usr/bin/env bash
set -euo pipefail

REGISTRY="ghcr.io/toruta39"
IMAGE="mirakurun"
MIRAKURUN_VERSION="$(cat "$(dirname "$0")/MIRAKURUN_VERSION" | tr -d '[:space:]')"
PLATFORM="linux/arm/v7"
BUILDER="orbstack"

docker buildx build \
  --builder "${BUILDER}" \
  --platform "${PLATFORM}" \
  --build-arg MIRAKURUN_VERSION="${MIRAKURUN_VERSION}" \
  -t "${REGISTRY}/${IMAGE}:latest-arm32v7" \
  -t "${REGISTRY}/${IMAGE}:${MIRAKURUN_VERSION}-arm32v7" \
  --push \
  .
