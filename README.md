# Apache Guacamole with LDAP Authentication (Docker)

## Overview

This project deploys an Apache Guacamole environment integrated with LDAP authentication using Docker Compose.

The repository is intended as a reusable lab environment that team members can clone, configure, and run locally.

## Architecture

Components included:

* Apache Guacamole (Web UI)
* guacd daemon
* PostgreSQL database
* LDAP integration
* Docker Compose orchestration

Refer to `ARCHITECTURE.md` for additional design details.

---

## Prerequisites

Install the following before starting:

### Required Software

* Docker Desktop (latest version)
* Docker Compose
* Git

Verify installation:

```bash
docker --version
docker compose version
git --version
```

---

## Clone the Repository

HTTPS:

```bash
git clone https://github.com/910756/apache-guacamole-ldap.git
```

SSH:

```bash
git clone git@github.com:910756/apache-guacamole-ldap.git
```

Enter the project folder:

```bash
cd apache-guacamole-ldap
```

---

## Environment Configuration

Copy the sample environment file:

```bash
cp .env.example .env
```

Windows PowerShell:

```powershell
copy .env.example .env
```

Update `.env` with the appropriate values.

Example:

```text
LDAP_SERVER=<your-ldap-server>
LDAP_BASE_DN=<your-base-dn>
LDAP_USER_SEARCH_FILTER=(uid={0})

POSTGRES_DB=guacamole_db
POSTGRES_USER=guacamole_user
POSTGRES_PASSWORD=<your-password>
```

Do not commit `.env` files containing real credentials.

---

## Start the Environment

Run:

```bash
docker compose up -d
```

Verify containers:

```bash
docker compose ps
```

Check logs:

```bash
docker compose logs -f
```

---

## Access Apache Guacamole

Open:

```text
http://localhost:8080/guacamole

http://127.0.0.1:8080/guacamole/#/

If localhost does not load, use 127.0.0.1.
```

Login using LDAP credentials.

---

## Stop the Environment

Stop containers:

```bash
docker compose down
```

Stop and remove volumes:

```bash
docker compose down -v
```

---

## Avoiding Conflicts with Existing Docker Labs

Before starting, check for existing containers:

```bash
docker ps -a
docker volume ls
docker network ls
```

Run the lab with an isolated project name if required:

```bash
docker compose -p guac-lab up -d
```

Remove the isolated environment:

```bash
docker compose -p guac-lab down -v
```

---

## Repository Structure

```text
.
├── docker-compose.yml
├── .env.example
├── README.md
├── ARCHITECTURE.md
├── RUNBOOK.md
└── scripts/
```

---

## Troubleshooting

### Port already allocated

Check active ports:

```bash
docker ps
```

or

```bash
netstat -ano
```

### View container logs

```bash
docker compose logs -f
```

### Restart the environment

```bash
docker compose down
docker compose up -d
```

---

## Notes

* Keep secrets out of GitHub.
* Never commit `.env` files containing passwords.
* Share `.env.example` instead.
* Use a private LDAP server appropriate for your environment.
