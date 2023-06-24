FROM alpine

COPY --from=crazymax/alpine-s6-dist:3.18 / /
CMD ["/init"]

# Install wireguard and nginx
RUN apk add -U wireguard-tools iptables iproute2 nginx

# Copy root filesystem
COPY rootfs /

