FROM bats/bats:1.2.1

RUN apk add --no-cache "git=2.24.4-r0"
RUN git clone https://github.com/ztombol/bats-support /opt/bats-support && \
git clone https://github.com/ztombol/bats-assert /opt/bats-assert && \
git clone https://github.com/lox/bats-mock /opt/lox-bats-mock

WORKDIR /
