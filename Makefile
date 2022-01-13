TAG?=v1

build:
	docker build -t klustair/kubeaudit:$(TAG) . -f Dockerfile

push:
	docker push klustair/kubeaudit:$(TAG)