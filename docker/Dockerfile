# FROM --platform=linux/amd64 ubuntu:22.04
FROM ubuntu:22.04

ARG ICESTORM_VERSION_TAG
ARG YOSYS_VERSION_TAG
ARG NEXTPNR_VERSION_TAG

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
  apt-get install -y \
  wget \
	gawk \
  git \
  make \
  python3 \
  lld \
  bison \
  clang \
  flex \
  libffi-dev \
  libfl-dev \
  libreadline-dev \
  pkg-config \
  tcl-dev \
  zlib1g-dev \
  graphviz \
  xdot \
  build-essential \
  mercurial \
  # python \
  libftdi-dev \
  # qt5-default \
  python3-dev \
  libboost-all-dev \
  libeigen3-dev \
  pip && \
  pip install cmake --upgrade && \
  export PATH=/usr/local/lib/python3.10/dist-packages:$PATH

RUN curl -LsSf https://astral.sh/uv/install.sh | sh

RUN mkdir /tmp/icestorm && \
  git clone https://github.com/YosysHQ/icestorm --single-branch --branch ${ICESTORM_VERSION_TAG} /tmp/icestorm && \
  cd /tmp/icestorm && make -j$(nproc) && make install

RUN mkdir /tmp/yosys && \
  git clone https://github.com/YosysHQ/yosys --single-branch --branch ${YOSYS_VERSION_TAG} /tmp/yosys && \
  cd /tmp/yosys && git submodule update --init --recursive && make -j$(nproc) && make install

RUN mkdir /tmp/nextpnr && \
  git clone https://github.com/YosysHQ/nextpnr --single-branch --branch ${NEXTPNR_VERSION_TAG} /tmp/nextpnr && \
  cd /tmp/nextpnr && git submodule update --init --recursive && mkdir -p build && cd build && cmake .. -DARCH=ice40 -DCMAKE_INSTALL_PREFIX=/usr/local && make -j$(nproc) && make install

VOLUME /work

WORKDIR /work
