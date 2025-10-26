alias b := build
alias p := push
alias r := run

IMAGE_NAME := "proskurekov/base-image"

default: build

run:
    docker run -it --rm {{IMAGE_NAME}} bash

build:
    docker buildx build -t {{IMAGE_NAME}} .

push:
	docker push {{IMAGE_NAME}}
