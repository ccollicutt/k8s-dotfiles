FROM ubuntu:20.04
RUN apt-get update && apt-get install -y lsb-release wget fonts-powerline
RUN useradd -ms /bin/bash k8sdotfile
USER k8sdotfile
COPY . /
RUN /install.sh
WORKDIR /home/k8sdotfile