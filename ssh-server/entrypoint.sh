$ssh = @'
#!/bin/bash
set -e

: "${SSH_NPA_USER:?SSH_NPA_USER is required}"
: "${SSH_NPA_PASSWORD:?SSH_NPA_PASSWORD is required}"

if ! id "$SSH_NPA_USER" >/dev/null 2>&1; then
    useradd -m -s /bin/bash "$SSH_NPA_USER"
fi

echo "${SSH_NPA_USER}:${SSH_NPA_PASSWORD}" | chpasswd

mkdir -p /var/run/sshd

exec /usr/sbin/sshd -D
'@

[System.IO.File]::WriteAllText("C:\guacamole-lab\ssh-server\entrypoint.sh", $ssh.Replace("`r`n","`n"))