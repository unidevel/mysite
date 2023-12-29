#!/bin/sh
docker buildx build \
  --push \
  --platform linux/amd64 \
  --tag unidevel/github-runner:latest --build-arg RUNNER_ARCH=linux-x64 .
