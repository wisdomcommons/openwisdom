# Contributing to Open Wisdom Platform

Welcome! We're building platform infrastructure to serve humanity's highest aspirations. Your contributions help create technology that supports wisdom communities, teachers, and seekers worldwide.

## Code of Conduct

Be kind, be wise, be constructive. We're here to serve the evolution of consciousness through excellent engineering.

## Development Setup

1. **Fork and clone** the repository
2. **Install dependencies**: `./scripts/setup/install-dependencies.sh`
3. **Set up local environment**: `./scripts/setup/local-dev-setup.sh`
4. **Create a feature branch**: `git checkout -b feature/your-feature-name`

## Contribution Areas

### Platform Infrastructure

-   **Infrastructure as Code**: Ansible playbooks, OpenTofu configurations
-   **Backend services**: APIs for auth, federation, content, payments
-   **Frontend applications**: Web interfaces for platform interaction
-   **Container orchestration**: Podman configurations and deployment
-   **Security improvements**: Hardening, monitoring, vulnerability fixes
-   **Performance optimization**: Database tuning, caching, scaling

### Documentation

-   **Technical guides**: API documentation, deployment instructions
-   **Architecture decisions**: ADRs, system design documentation
-   **User guides**: Platform usage, teacher/student onboarding
-   **Development docs**: Contributing guides, coding standards

## Repository Scope

**This repository contains:**

-   Platform infrastructure and services
-   Web applications for wisdom community interaction
-   Deployment and orchestration automation

**This repository does NOT contain:**

-   Wisdom teachings, practices, or educational content
-   Meditation instructions or philosophical texts

## Platform Architecture

The Open Wisdom platform enables:

-   **Federation**: ActivityPub protocol for distributed wisdom communities
-   **Discovery**: Search and recommendation across wisdom repositories
-   **Collaboration**: Git-based workflows for wisdom content development
-   **Sustainability**: Integrated payment systems for teacher support

## License Headers

### For All Platform Code (.py, .js, .ts, .yml, .sh files):

```
# Copyright (C) 2025 Open Wisdom Contributors
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published
# by the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
```

## Pull Request Process

1. **Test locally** before submitting
2. **Write clear commit messages** explaining the why, not just the what
3. **Include tests** for new functionality
4. **Update documentation** as needed
5. **Follow existing code style** and conventions
6. **Security review**: Ensure changes maintain security posture

## Infrastructure Changes

-   **Test with local inventory** first: `ansible-playbook -i inventories/local/hosts playbooks/site.yml --check`
-   **Security first**: All changes should maintain or improve security posture
-   **Document decisions**: Add architecture decision records (ADRs) for significant changes
-   **Environment parity**: Ensure changes work across dev/staging/production

## Service Development

-   **API-first design**: Services communicate through well-defined APIs
-   **Containerization**: All services must be containerizable with Podman
-   **Federation-ready**: Consider ActivityPub integration from the start
-   **Monitoring**: Include health checks and metrics endpoints
-   **Security**: Implement proper authentication and authorization

## Testing Strategy

-   **Unit tests**: Test individual components and functions
-   **Integration tests**: Test service interactions
-   **Infrastructure tests**: Validate Ansible playbooks and configurations
-   **Security tests**: Scan for vulnerabilities and misconfigurations

## Getting Help

-   **Technical questions**: Open an issue with the `question` label
-   **Bugs**: Open an issue with the `bug` label and reproduction steps
-   **Feature requests**: Open an issue with the `enhancement` label
-   **Security issues**: Email security@open-wisdom.org (not public issues)

## Recognition

All contributors are honored in our community. Significant contributions will be recognized in project documentation and community celebrations.

Thank you for building the infrastructure that enables wisdom to flourish! 🙏
