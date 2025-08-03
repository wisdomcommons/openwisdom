#!/bin/bash
set -euo pipefail

echo "Bootstrapping Open Wisdom VPS..."

# Check if we're in the right directory
if [[ ! -f "infrastructure/ansible/playbooks/vps-bootstrap.yml" ]]; then
    echo "Error: Must be run from the Open Wisdom repository root"
    exit 1
fi

# Check if SSH key exists
if [[ ! -f ~/.ssh/open_wisdom_vps ]]; then
    echo "Error: SSH key not found at ~/.ssh/open_wisdom_vps"
    echo "Please ensure your VPS SSH key is properly configured"
    exit 1
fi

# Test SSH connectivity
echo "Testing SSH connectivity to VPS..."
if ! ssh -i ~/.ssh/open_wisdom_vps -o ConnectTimeout=10 root@open-wisdom.org 'echo "SSH connection successful"'; then
    echo "Error: Cannot connect to VPS via SSH"
    exit 1
fi

# Run bootstrap playbook
echo "Running VPS bootstrap playbook..."
cd infrastructure/ansible
ansible-playbook -i inventories/production/hosts playbooks/vps-bootstrap.yml

echo "VPS bootstrap completed successfully!"
echo "Next steps:"
echo "1. Run the full site configuration: ansible-playbook -i inventories/production/hosts playbooks/site.yml"
echo "2. Set up application-specific configurations"
