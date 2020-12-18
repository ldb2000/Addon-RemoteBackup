#!/bin/bash
set -ev

echo "Running local build test."

# build zigbee2mqtt
docker run -it --rm --privileged --name "remotebackup" \
    -v ~/.docker:/root/.docker \
    -v "$(pwd)":/docker \
    hassioaddons/build-env:latest \
    --target "remotebackup" \
    --tag-test \
    --armhf \
    --from "homeassistant/{arch}-base" \
    --author "laurent.deberti <ldb2000@github.com>" \
    --doc-url "https://github.com/ldb2000/Addon-RemoteBackup/" \
    --parallel
