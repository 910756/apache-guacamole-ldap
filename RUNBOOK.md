\# RUNBOOK - Apache Guacamole SSH/RDP Gateway



\## Objective



Build a gateway portal that allows users to SSH or RDP into runtime machines using Apache Guacamole.



Authentication into Guacamole is performed via LDAP.



Authorization is implemented using group-based RBAC.



Target machine authentication uses non-personal accounts (NPA).



\---



\## Components



| Component        | Purpose                          |

| ---------------- | -------------------------------- |

| Apache Guacamole | Gateway portal                   |

| OpenLDAP         | User authentication              |

| PostgreSQL       | Guacamole configuration database |

| guacd            | Protocol proxy daemon            |

| Linux Desktop    | RDP target machine               |

| Linux Server 1   | SSH target machine               |

| Linux Server 2   | SSH target machine               |



\---



\## LDAP Users



| User  | Password | Group         |

| ----- | -------- | ------------- |

| Alice | alice123 | Desktop Users |

| Bob   | bob123   | SSH Users     |



\---



\## Target Machines



| Machine        | Protocol | Hostname | Port |

| -------------- | -------- | -------- | ---- |

| Linux Desktop  | RDP      | desktop  | 3389 |

| Linux Server 1 | SSH      | ssh1     | 22   |

| Linux Server 2 | SSH      | ssh2     | 22   |



\---



\## Non-Personal Accounts (NPA)



\### SSH



Username



```text

sshuser

```



Password



```text

ssh123

```



\### RDP



Username



```text

desktopuser

```



Password



```text

desktop123

```



In production, NPA passwords should be retrieved from a privileged access management solution such as CyberArk.



Passwords are intentionally not stored inside Guacamole.



\---



\## RBAC Mapping



| LDAP Group    | Guacamole Access               |

| ------------- | ------------------------------ |

| Desktop Users | Linux Desktop                  |

| SSH Users     | Linux Server 1, Linux Server 2 |



\---



\## Startup Procedure



Navigate to project folder.



```powershell

cd C:\\guacamole-lab

```



Start services.



```powershell

docker compose up -d

```



Verify containers.



```powershell

docker ps

```



Open portal.



```text

http://127.0.0.1:8080/guacamole/

```



\---



\## Validation Steps



\### Alice



Login



```text

alice

alice123

```



Expected



```text

RDP

Linux Desktop

```



When prompted:



```text

desktop123

```



\---



\### Bob



Login



```text

bob

bob123

```



Expected



```text

SSH

Linux Server 1

Linux Server 2

```



When prompted:



```text

ssh123

```



\---



\## Health Verification



Verify all containers.



```powershell

docker ps

```



Expected containers:



```text

ldap

guac-postgres

guacamole

guacd

ssh1

ssh2

desktop

```



Expected health:



```text

healthy

```



\---



\## Safe Commands



Start environment.



```powershell

docker compose up -d

```



Stop environment.



```powershell

docker compose down

```



Restart environment.



```powershell

docker compose restart

```



\---



\## Commands To Avoid



Do NOT execute.



```powershell

docker compose down -v

```



```powershell

docker volume prune

```



```powershell

docker system prune -a

```



These commands will remove persistent data.



\---



\## Persistence



The following data persists across restarts:



\* LDAP users

\* LDAP groups

\* PostgreSQL database

\* Guacamole RBAC

\* Guacamole connections

\* Connection groups

\* Health checks



