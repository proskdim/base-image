alias b := build
alias p := push

IMAGE_NAME := "codex/base-image"

default: build

[doc('build docker image')]
build:
    docker buildx build -t {{IMAGE_NAME}} .

[doc('push docker image')]
push:
	docker push {{IMAGE_NAME}}
