#!/bin/bash
set -e

: "${RDP_NPA_USER:?RDP_NPA_USER is required}"
: "${RDP_NPA_PASSWORD:?RDP_NPA_PASSWORD is required}"

if ! id "$RDP_NPA_USER" >/dev/null 2>&1; then
    useradd -m -s /bin/bash "$RDP_NPA_USER"
fi

echo "${RDP_NPA_USER}:${RDP_NPA_PASSWORD}" | chpasswd

echo "startxfce4" > "/home/${RDP_NPA_USER}/.xsession"
chown "${RDP_NPA_USER}:${RDP_NPA_USER}" "/home/${RDP_NPA_USER}/.xsession"

mkdir -p /var/run/xrdp

/usr/sbin/xrdp-sesman

exec /usr/sbin/xrdp --nodaemon