#!/bin/bash

set -e

if [[ "$DOCKER_BIND_MOUNT_IN_USE" = "true" ]]; then
    yarn install --frozen-lockfile
fi

if [[ "$DEV_SERVER" = "true" ]]; then
    yarn run develop
else
    yarn run start
fi
