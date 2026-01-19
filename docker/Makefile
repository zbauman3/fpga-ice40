YOSYS_VERSION_TAG := "v0.60"
NEXTPNR_VERSION_TAG := "nextpnr-0.9"
ICESTORM_VERSION_TAG := "v1.1"

build: docker/Dockerfile Makefile
	docker build \
		-t ice40:latest \
		--build-arg ICESTORM_VERSION_TAG=${ICESTORM_VERSION_TAG} \
		--build-arg YOSYS_VERSION_TAG=${YOSYS_VERSION_TAG} \
		--build-arg NEXTPNR_VERSION_TAG=${NEXTPNR_VERSION_TAG} \
		-f $< .
	touch $@
