FROM node:current-slim AS node
FROM debian:bookworm-slim AS base

ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -yqq --no-install-recommends \
    curl git wget \
    python3-pip \
    libyaml-dev \
    zip unzip \ 
    software-properties-common \
    yamllint \
    yq jq \
    libatomic1 \
    make \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
    
COPY ./common /opt/codex/common

# Install Node
COPY --from=node /usr/local/bin/node /usr/local/bin/node
COPY --from=node /usr/local/include/node /usr/local/include/node
COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules
# Install yarn
COPY --from=node /opt/yarn-v*/bin/* /usr/local/bin/
COPY --from=node /opt/yarn-v*/lib/* /usr/local/lib/
# Link npm and yarn
RUN ln -vs /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm \
    && ln -vs /usr/local/lib/node_modules/npm/bin/npx-cli.js /usr/local/bin/npx

RUN npm install -g ajv-cli

CMD ["/bin/bash"]