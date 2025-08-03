# Open Wisdom Architecture Overview

## System Architecture

Open Wisdom is built as a modular, federated platform using modern open source technologies.

### Core Principles

1. **Infrastructure as Code**: All infrastructure is version-controlled and reproducible
2. **Container-First**: All services run in Podman containers for consistency and security
3. **Federation-Ready**: Designed from the ground up to support ActivityPub federation
4. **Security by Design**: Rootless containers, minimal privileges, defense in depth
5. **Open Source**: 100% FOSS stack

### Technology Stack

-   **Infrastructure**: OpenTofu (provisioning) + Ansible (configuration)
-   **Runtime**: Podman (containers) + systemd (service management)
-   **Web Server**: Nginx (reverse proxy, SSL termination)
-   **Database**: PostgreSQL (primary data store)
-   **Git Hosting**: Forgejo (self-hosted, federated Git)
-   **Monitoring**: Prometheus + Grafana + Loki

### Current VPS Setup

Single VPS running Debian hosting:

-   Web applications behind Nginx reverse proxy
-   PostgreSQL database for application data
-   Forgejo for git repository hosting
-   Monitoring stack for observability

### Future Federation Architecture

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│  Open Wisdom    │    │  Partner Org    │    │  Individual     │
│  Main Instance  │◄──►│  Federated      │◄──►│  Wisdom Teacher │
│                 │    │  Instance       │    │  Instance       │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         ▲                       ▲                       ▲
         │                       │                       │
         ▼                       ▼                       ▼
┌─────────────────────────────────────────────────────────────────┐
│              Federated Wisdom Network                           │
│           (ActivityPub Protocol)                                │
└─────────────────────────────────────────────────────────────────┘
```

### Security Model

-   **Network**: UFW firewall, fail2ban intrusion detection
-   **Application**: Rootless containers, non-privileged users
-   **Data**: Encrypted backups, secure secrets management
-   **Access**: SSH key authentication, minimal exposed services
-   **Updates**: Automated security updates, vulnerability scanning

## Development Workflow

1. **Local Development**: Podman compose environment mirrors production
2. **Testing**: Ansible playbooks tested against local inventory
3. **Staging**: Deploy to staging environment for integration testing
4. **Production**: Automated deployment via Ansible playbooks

## Deployment Architecture

```
Developer → Git Push → CI/CD Pipeline → Ansible Deployment → Production VPS
     ▲                                                             │
     └─── Local Testing ← Staging Environment ←────────────────────┘
```
