# Download 1Password CLI

FROM alpine as download

RUN apk add curl unzip

ENV ARCH amd64
ENV OP_CLI_VERSION v2.18.0

RUN curl -sSfo op.zip https://cache.agilebits.com/dist/1P/op2/pkg/${OP_CLI_VERSION}/op_linux_${ARCH}_${OP_CLI_VERSION}.zip \
  && unzip -od /usr/local/bin/ op.zip \
  && rm op.zip

FROM alpine

# Install s6 overlay
COPY --from=crazymax/alpine-s6-dist:3.18 / /
CMD ["/init"]

# Copy 1Password CLI
RUN apk add libc6-compat
COPY --from=download /usr/local/bin/op /usr/local/bin/op

# Install wireguard
RUN apk add -U wireguard-tools iptables iproute2

# Copy root filesystem
COPY rootfs /