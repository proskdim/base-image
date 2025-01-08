build:
	docker buildx build -t hexletbasics/base-image .

push:
	docker push hexletbasics/base-image
