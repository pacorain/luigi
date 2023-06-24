FROM jc21/nginx-proxy-manager:latest

# Install wireguard
RUN apt-get update && apt-get install -y wireguard

# Copy root filesystem
# TODO: Turn this back on
# COPY rootfs /