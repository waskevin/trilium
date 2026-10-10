#!/bin/sh
# Build the TOS 7 submission package for trilium.
# Produces: trilium.tar.gz and trilium.tar.gz.sha256
set -e

APPID=trilium
VERSION=1.0.0

tar -czf "${APPID}.tar.gz" config.ini "${APPID}.lang" "${APPID}.svg" docker-compose.yml
sha256sum "${APPID}.tar.gz" > "${APPID}.tar.gz.sha256"

echo "built ${APPID}.tar.gz (version ${VERSION})"
cat "${APPID}.tar.gz.sha256"