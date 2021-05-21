ARG BASE_IMAGE=node
ARG NODE_VERSION=16.0.0
ARG IMAGE_VARIANT=slim

# ==============================
FROM ${BASE_IMAGE}:${NODE_VERSION}-${IMAGE_VARIANT} AS base_stage
# ==============================

RUN groupadd --system --gid 2000 non-root-group && \
    useradd  --system --gid      non-root-group --create-home --uid 3000 appuser

WORKDIR /app

EXPOSE 3000

COPY package.json yarn.lock /app/

# ==============================
FROM base_stage AS development_stage
# ==============================

# git is needed for 'husky install' to work
RUN apt-get update && apt-get install --yes --no-install-recommends git

RUN yarn install --frozen-lockfile --production=false && \
    yarn cache clean

COPY . /app/

USER appuser:non-root-group
CMD ["yarn", "develop"]

# ==============================
FROM base_stage AS production_stage
# ==============================

RUN yarn install --frozen-lockfile --production=true && \
    yarn cache clean

COPY . /app/

USER appuser:non-root-group
CMD ["yarn", "start"]
