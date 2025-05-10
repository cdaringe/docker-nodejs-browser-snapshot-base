#!/usr/bin/env bash
docker buildx build \
  --platform linux/amd64 \
  -t cdaringe/docker-nodejs-browser-snapshot-base \
  --push .
