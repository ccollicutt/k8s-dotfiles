FROM ubuntu:20.04
RUN apt-get update && \
    apt-get install --no-install-recommends -y lsb-release=11.1.0ubuntu2 wget=1.20.3-1ubuntu1 fonts-powerline=2.7-3 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
RUN useradd -ms /bin/bash k8sdotfile
USER k8sdotfile
COPY . /
RUN /install.sh
WORKDIR /home/k8sdotfile