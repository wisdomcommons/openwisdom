# Local Development Setup

## Prerequisites

- Git
- OpenTofu
- Ansible  
- Podman
- A Unix-like operating system (Linux, macOS)

## Quick Start

1. **Clone the repository**:
   ```bash
   git clone https://github.com/wisdomcommons/openwisdom.git
   cd openwisdom
   ```

2. **Install dependencies**:
   ```bash
   ./scripts/setup/install-dependencies.sh
   ```

3. **Set up local development environment**:
   ```bash
   ./scripts/setup/local-dev-setup.sh
   ```

4. **Test Ansible configuration locally**:
   ```bash
   cd infrastructure/ansible
   ansible-playbook -i inventories/local/hosts playbooks/vps-bootstrap.yml --ask-become-pass
   ```

## Development Workflow

### Testing Infrastructure Changes

Before deploying to production, test your Ansible playbooks locally:

```bash
# Syntax check
ansible-playbook --syntax-check playbooks/site.yml

# Dry run against local inventory
ansible-playbook -i inventories/local/hosts playbooks/site.yml --check

# Apply locally (for safe changes)
ansible-playbook -i inventories/local/hosts playbooks/site.yml --ask-become-pass
```

### Container Development

Use Podman for local container development:

```bash
# Build a service container
cd services/zoom-webhook-relay
podman build -t zoom-webhook-relay .

# Run locally
podman run -p 8000:8000 zoom-webhook-relay

# Test with compose
cd infrastructure/containers/compose
podman-compose -f development.yml up -d
```

## Directory Structure

- `infrastructure/ansible/`: Configuration management
- `infrastructure/tofu/`: Infrastructure provisioning  
- `services/`: Backend services and APIs
- `scripts/`: Automation and utility scripts
- `docs/`: Documentation

## Next Steps

After local setup:
1. Review the architecture documentation
2. Understand the Ansible playbook structure
3. Set up VPS access for deployment
4. Configure secrets management
