FROM ubuntu:20.04

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -yqq \
    git curl python3-pip libyaml-dev zip unzip jq
RUN pip3 install yamllint yq
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && apt-get install -y nodejs
RUN npm install -g ajv-cli

COPY ./common /tmp/basics/common
