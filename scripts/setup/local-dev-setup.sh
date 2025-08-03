#!/bin/bash
set -euo pipefail

echo "Setting up Open Wisdom local development environment..."

# Check if we're in the right directory
if [[ ! -f "README.md" ]] || ! grep -q "Open Wisdom" README.md; then
    echo "Error: Must be run from the Open Wisdom repository root"
    exit 1
fi

# Install dependencies if not already installed
if ! command -v ansible &> /dev/null || ! command -v podman &> /dev/null || ! command -v tofu &> /dev/null; then
    echo "Installing missing dependencies..."
    ./scripts/setup/install-dependencies.sh
fi

# Create local inventory for testing
mkdir -p infrastructure/ansible/inventories/local
cat > infrastructure/ansible/inventories/local/hosts << 'LOCAL_EOF'
[local]
localhost ansible_connection=local

[local:vars]
environment=local
domain_name=localhost
ansible_python_interpreter=/usr/bin/python3
LOCAL_EOF

# Create local group vars
mkdir -p infrastructure/ansible/inventories/local/group_vars/all
cat > infrastructure/ansible/inventories/local/group_vars/all/main.yml << 'LOCAL_EOF'
---
# Local development configuration
timezone: "UTC"
locale: "en_US.UTF-8"
app_user: "{{ ansible_user }}"
app_group: "{{ ansible_user }}"
app_directory: "{{ ansible_user_dir }}/open-wisdom-local"
ssh_port: 22
fail2ban_enabled: false
ufw_enabled: false
LOCAL_EOF

echo "Local development environment setup complete!"
echo "You can now test Ansible playbooks locally with:"
echo "cd infrastructure/ansible && ansible-playbook -i inventories/local/hosts playbooks/vps-bootstrap.yml --ask-become-pass"
