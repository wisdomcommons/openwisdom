# Open Wisdom Platform

Open source distributed platform infrastructure for wisdom collaboration and federation.

## Vision

Open Wisdom Platform provides the technical infrastructure for a global ecosystem where wisdom is freely shared, collaboratively developed, and sustainably supported. This repository contains the platform code that facilitates wisdom communities - the teachings themselves live in separate, focused repositories.

## What This Repository Contains

**Platform Infrastructure:**

-   Federated backend services (ActivityPub, authentication, content APIs)
-   Web applications for discovery and collaboration
-   Infrastructure as Code (Ansible, OpenTofu)
-   Container orchestration and deployment automation

**What This Repository Does NOT Contain:**

-   Wisdom teachings, practices, or educational content
-   Meditation instructions or philosophical texts

_Wisdom content lives in separate repositories that can be forked, evolved, and federated independently._

## Quick Start

### Prerequisites

-   OpenTofu (Infrastructure provisioning)
-   Ansible (Configuration management)
-   Podman (Container runtime)
-   Git (Version control)

### Local Development Setup

```bash
# Install dependencies
./scripts/setup/install-dependencies.sh

# Set up local development environment
./scripts/setup/local-dev-setup.sh

# Bootstrap VPS (production)
./scripts/setup/bootstrap-vps.sh
```

## Architecture

This platform enables:

-   **Federated collaboration** on wisdom content across repositories
-   **Community formation** around specific teachings and practices
-   **Sustainable support** for wisdom teachers through integrated payments
-   **Discovery and navigation** of the distributed wisdom commons

### Repository Structure

-   **Infrastructure**: Ansible playbooks and OpenTofu configurations
-   **Services**: Backend APIs (auth, federation, content, payments)
-   **Frontend**: Web applications and user interfaces
-   **Documentation**: Architecture, deployment, and API guides

## Platform Services

### Current Services

-   **zoom-webhook-relay**: Automated processing of recorded wisdom sessions

### Planned Services

-   **Auth Service**: User authentication and authorization (SSO)
-   **Federation Service**: ActivityPub protocol implementation
-   **Content Service**: API for wisdom repository integration
-   **Payment Service**: Teacher support and micro-donations
-   **Discovery Service**: Search and recommendation across wisdom streams

## Licensing

-   AGPL-3.0: All software, infrastructure, technical implementations, and documentation in this repository

See [LICENSE](LICENSE) for detailed licensing information.

## Wisdom Content Repositories

Wisdom teachings are maintained in separate repositories with CC0 licensing:

-   Teachers can fork specific wisdom lineages
-   No technical barriers to wisdom collaboration
-   Independent evolution of teachings and platform

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for development workflow and guidelines.

## Values

-   **Open Source**: 100% FOSS stack, no vendor lock-in
-   **Federation**: Built for the decentralized wisdom commons
-   **Security**: Rootless containers, minimal privileges, defense in depth
-   **Separation of Concerns**: Platform infrastructure separate from wisdom content
-   **Community**: Serving individual, communal, and planetary healing and humanity's highest aspirations through technology
