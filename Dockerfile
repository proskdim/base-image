FROM node:current-slim AS node
FROM debian:bookworm-slim AS base

ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

# install packages
RUN apt-get update && apt-get install -yqq --no-install-recommends ca-certificates \
    curl git \
    libyaml-dev \
    yamllint \
    zip unzip \ 
    yq jq \
    libatomic1 \
    make \
    gcc \
    libc6-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# copy common 
COPY ./common /opt/codex/common

#intall janet
RUN git clone https://github.com/janet-lang/janet.git && \
    cd janet && \
    make test && \
    make install
    
# install janet package manager
RUN git clone https://github.com/janet-lang/jpm && \
    cd jpm && \
    janet bootstrap.janet && \
    jpm install spork

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

# install validator
RUN npm install -g ajv-cli

CMD ["/bin/bash"]