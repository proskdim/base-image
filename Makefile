build:
	docker buildx build -t codex/base-image .

push:
	docker push codex/base-image
