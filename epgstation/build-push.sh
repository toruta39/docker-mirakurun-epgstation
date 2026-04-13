#!/usr/bin/env bash
set -euo pipefail

REGISTRY="ghcr.io/toruta39"
IMAGE="epgstation"
VERSION="$(grep '^FROM' "$(dirname "$0")/debian.Dockerfile" | sed 's/.*epgstation:\(v[^-]*\).*/\1/')"
PLATFORM="linux/amd64,linux/arm64,linux/arm/v7"
BUILDER="zealous_cohen" # change to builder name

docker buildx build \
  --builder "${BUILDER}" \
  --platform "${PLATFORM}" \
  -f "$(dirname "$0")/debian.Dockerfile" \
  -t "${REGISTRY}/${IMAGE}:latest" \
  -t "${REGISTRY}/${IMAGE}:${VERSION}" \
  --push \
  "$(dirname "$0")"
