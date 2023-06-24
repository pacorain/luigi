FROM ubuntu:jammy

ARG S6_OVERLAY_VERSION=3.1.5.0

# Install s6 overlay
RUN apt-get update && apt-get install -y xz-utils
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-x86_64.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-x86_64.tar.xz
CMD ["/init"]

# Install wireguard
RUN apt-get update && apt-get install -y wireguard iptables iproute2

# Copy root filesystem
COPY rootfs /