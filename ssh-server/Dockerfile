FROM ubuntu:24.04

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y openssh-server sudo bash && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config && \
    printf '%s\n' \
'#!/bin/bash' \
'set -e' \
': "${SSH_NPA_USER:?SSH_NPA_USER is required}"' \
': "${SSH_NPA_PASSWORD:?SSH_NPA_PASSWORD is required}"' \
'if ! id "$SSH_NPA_USER" >/dev/null 2>&1; then useradd -m -s /bin/bash "$SSH_NPA_USER"; fi' \
'echo "${SSH_NPA_USER}:${SSH_NPA_PASSWORD}" | chpasswd' \
'mkdir -p /var/run/sshd' \
'exec /usr/sbin/sshd -D' \
> /entrypoint.sh && \
    chmod +x /entrypoint.sh && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 22

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]