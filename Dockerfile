FROM ubuntu:20.04

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -yqq \
    git curl python3-pip libyaml-dev zip unzip \
    nodejs npm \
    jq
RUN pip3 install yamllint yq
RUN npm install -g ajv-cli

COPY common /tmp/basics/common
