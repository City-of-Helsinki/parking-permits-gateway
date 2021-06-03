ARG BASE_IMAGE=node
ARG NODE_VERSION=16.0.0
ARG IMAGE_VARIANT=slim

# ==============================
FROM ${BASE_IMAGE}:${NODE_VERSION}-${IMAGE_VARIANT} AS base_stage
# ==============================

WORKDIR /app

EXPOSE 3000

# Add tini init system https://github.com/krallin/tini
ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

COPY docker-entrypoint.sh /app/
ENTRYPOINT ["/tini", "--", "/app/docker-entrypoint.sh"]

COPY package.json yarn.lock /app/

# ==============================
FROM base_stage AS development_stage
# ==============================

# git is needed for 'husky install' to work
RUN apt-get update && apt-get install --yes --no-install-recommends git

RUN yarn install --frozen-lockfile --production=false && \
    yarn cache clean

COPY . /app/

# ==============================
FROM base_stage AS production_stage
# ==============================

RUN yarn install --frozen-lockfile --production=true && \
    yarn cache clean

COPY . /app/
