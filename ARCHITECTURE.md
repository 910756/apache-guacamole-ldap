\# Architecture - Apache Guacamole SSH/RDP Gateway



\## Overview



This lab provides a Docker Compose based Apache Guacamole gateway for SSH and RDP access into runtime machines.



Users authenticate to Guacamole using LDAP credentials. Access to machines is controlled through group-based RBAC.



Target machine authentication uses non-personal accounts. The NPA passwords are not stored in Guacamole and are entered by the user when opening the target connection.



\## Components



```text

Users

&#x20;Alice / Bob

&#x20;   |

&#x20;   v

Apache Guacamole Portal

&#x20;   |

&#x20;   +--> OpenLDAP

&#x20;   |      - Alice

&#x20;   |      - Bob

&#x20;   |      - Desktop Users

&#x20;   |      - SSH Users

&#x20;   |

&#x20;   +--> PostgreSQL

&#x20;   |      - Connections

&#x20;   |      - Connection groups

&#x20;   |      - RBAC bridge

&#x20;   |

&#x20;   +--> guacd

&#x20;          |

&#x20;          +--> Linux Desktop via RDP

&#x20;          +--> Linux Server 1 via SSH

&#x20;          +--> Linux Server 2 via SSH

