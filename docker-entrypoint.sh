#!/bin/bash

set -e

if [[ "$WAIT_FOR_OPEN_CITY_PROFILE_GRAPHQL_API" = "true" ]]; then
    ADDRESS=$(echo $OPEN_CITY_PROFILE_GRAPHQL_API | cut -c 8-27)
    ./wait-for-it.sh $ADDRESS --timeout=120
fi

if [[ "$WAIT_FOR_PARKING_PERMITS_GRAPHQL_API" = "true" ]]; then
    ADDRESS=$(echo $PARKING_PERMITS_GRAPHQL_API | cut -c 8-31)
    ./wait-for-it.sh $ADDRESS --timeout=120
fi

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
