#!/bin/bash

set -e

if [[ "$DOCKER_BIND_MOUNT_IN_USE" = "true" && ! -d "/app/node_modules/" ]]; then
    yarn install --frozen-lockfile
fi

if [[ "$INSTALL_PRECOMMIT" = "true" ]]; then
    yarn run husky install
fi

if [[ "$DEV_SERVER" = "true" ]]; then
    yarn run develop
else
    yarn run start
fi
