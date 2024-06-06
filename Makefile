build:
	docker build -t hexletbasics/base-image .

push:
	docker push hexletbasics/base-image

check:
	make -C fixtures schema-validate

ci-check:
	docker-compose --file docker-compose.yml build
	docker-compose --file docker-compose.yml up --abort-on-container-exit
