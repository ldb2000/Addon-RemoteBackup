#!/bin/bash
set -ev

if [ -z "${TRAVIS_TAG}" ]; then
    echo "Untagged build found. Testing building remotebackup with tag 'test' and remotebackup-edge with tag 'test'."
    # build zigbee2mqtt
    docker run -it --rm --privileged --name "${ADDON_NAME}" \
        -v ~/.docker:/root/.docker \
        -v "$(pwd)":/docker \
        hassioaddons/build-env:latest \
        --target "${ADDON_NAME}" \
        --tag-test \
        --all \
        --from "homeassistant/{arch}-base" \
        --author "Laurent De Berti <ldb2000@github.com>" \
        --doc-url "${GITHUB_URL}" \
        --login "${DOCKER_USERNAME}" \
        --password "${DOCKER_PASSWORD}" \
        --parallel
    # build remotebackup-edge
    docker run -it --rm --privileged --name "${ADDON_NAME_EDGE}" \
        -v ~/.docker:/root/.docker \
        -v "$(pwd)":/docker \
        hassioaddons/build-env:latest \
        --target "${ADDON_NAME_EDGE}" \
        --tag-test \
        --all \
        --from "homeassistant/{arch}-base" \
        --author "Laurent De Berti <ldb2000@github.com>" \
        --doc-url "${GITHUB_URL}" \
        --login "${DOCKER_USERNAME}" \
        --password "${DOCKER_PASSWORD}" \
        --parallel \
        --arg COMMIT "${TRAVIS_COMMIT}"
else
    echo "New git tagged build found. Testing building remotebackup with tag 'latest'."
    docker run -it --rm --privileged --name "${ADDON_NAME}" \
        -v ~/.docker:/root/.docker \
        -v "$(pwd)":/docker \
        hassioaddons/build-env:latest \
        --target "${ADDON_NAME}" \
        --tag-latest \
        --all \
        --from "homeassistant/{arch}-base" \
        --author "Laurent De Berti <ldb2000@github.com>" \
        --doc-url "${GITHUB_URL}" \
        --login "${DOCKER_USERNAME}" \
        --password "${DOCKER_PASSWORD}" \
        --parallel \
        --arg COMMIT "${TRAVIS_COMMIT}"
fi
echo "Local Docker build successful."
