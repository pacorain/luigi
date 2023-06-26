FROM alpine

# Install s6 overlay
COPY --from=crazymax/alpine-s6-dist:3.18 / /
CMD ["/init"]

# Install wireguard
RUN apk add -U wireguard-tools iptables iproute2

# Copy root filesystem
COPY rootfs /