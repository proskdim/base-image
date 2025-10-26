FROM node:current-slim AS node
FROM proskurekov/janet AS janet
FROM debian:bookworm-slim AS base

ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

# install packages
RUN apt-get update && apt-get install -yqq --no-install-recommends ca-certificates \
    curl git vim \
    libyaml-dev \
    yamllint \
    zip unzip \
    yq jq \
    libatomic1 \
    make \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# copy common
COPY ./common /opt/codex/common

# install janet from head branch
COPY --from=janet /usr/local/bin /usr/local/bin
COPY --from=janet /usr/local/lib /usr/local/lib

# install node
COPY --from=node /usr/local/bin/node /usr/local/bin/node
COPY --from=node /usr/local/include/node /usr/local/include/node
COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules

# install yarn
COPY --from=node /opt/yarn-v*/bin/* /usr/local/bin/
COPY --from=node /opt/yarn-v*/lib/* /usr/local/lib/

# Link npm and yarn
RUN ln -vs /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm \
    && ln -vs /usr/local/lib/node_modules/npm/bin/npx-cli.js /usr/local/bin/npx

# install validator
RUN npm install -g ajv-cli

# install just
RUN npm install -g rust-just

CMD ["/bin/bash"]
