FROM ubuntu:24.04

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y xfce4 xrdp dbus-x11 sudo bash && \
    adduser xrdp ssl-cert && \
    printf '%s\n' \
'#!/bin/bash' \
'set -e' \
': "${RDP_NPA_USER:?RDP_NPA_USER is required}"' \
': "${RDP_NPA_PASSWORD:?RDP_NPA_PASSWORD is required}"' \
'if ! id "$RDP_NPA_USER" >/dev/null 2>&1; then useradd -m -s /bin/bash "$RDP_NPA_USER"; fi' \
'echo "${RDP_NPA_USER}:${RDP_NPA_PASSWORD}" | chpasswd' \
'echo "startxfce4" > "/home/${RDP_NPA_USER}/.xsession"' \
'chown "${RDP_NPA_USER}:${RDP_NPA_USER}" "/home/${RDP_NPA_USER}/.xsession"' \
'mkdir -p /var/run/xrdp' \
'/usr/sbin/xrdp-sesman' \
'exec /usr/sbin/xrdp --nodaemon' \
> /entrypoint.sh && \
    chmod +x /entrypoint.sh && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 3389

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]