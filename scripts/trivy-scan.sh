#!/bin/bash
set -e

BASE_DIR="/home/localuser/devoir-artcoded/artcoded"
DATE=$(date +%F)

mkdir -p "$BASE_DIR/data/reports/trivy"

IMAGES=$(docker images --format "{{.Repository}}:{{.Tag}}" | grep -v "<none>")

for image in $IMAGES; do

    SAFE_NAME=$(echo "$image" | tr '/:' '_')

    echo "[+] Scanning $image"

    docker run --rm \
      -v /var/run/docker.sock:/var/run/docker.sock \
      -v "$BASE_DIR":/work \
      -v "$BASE_DIR/data/trivy":/root/.cache/ \
      aquasec/trivy:latest image \
      --severity HIGH,CRITICAL \
      --format template \
      --template "@/work/templates/trivy-html.tpl" \
      -o "/work/data/reports/trivy/${SAFE_NAME}-${DATE}.html" \
      "$image"

done

echo "[+] Trivy scan completed."
