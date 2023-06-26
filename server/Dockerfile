FROM alpine

# Install s6 overlay
COPY --from=crazymax/alpine-s6-dist:3.18 / /
CMD ["/init"]

# Install nginx and wireguard
RUN apk add -U wireguard-tools iptables iproute2 nginx-mod-stream

# Copy root filesystem
COPY rootfs /

