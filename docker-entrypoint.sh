#!/bin/bash

set -e

if [[ "$WAIT_FOR_PARKING_PERMITS_GRAPHQL_API" = "true" ]]; then
    ADDRESS=$(echo $PARKING_PERMITS_GRAPHQL_API | cut -c 8-)
    ./wait-for-it.sh $ADDRESS --timeout=120
fi

if [[ "$DOCKER_BIND_MOUNT_IN_USE" = "true" && ! -d "/app/node_modules/" ]]; then
    yarn install --frozen-lockfile
fi

if [[ "$INSTALL_PRECOMMIT" = "true" ]]; then
    yarn run husky install
fi

