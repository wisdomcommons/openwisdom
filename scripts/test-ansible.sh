#!/bin/bash
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

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
COMPOSE_DIR="$PROJECT_ROOT/infrastructure/containers/compose"
ANSIBLE_DIR="$PROJECT_ROOT/infrastructure/ansible"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log() {
    echo -e "${GREEN}[$(date +'%Y-%m-%d %H:%M:%S')] $1${NC}"
}

warn() {
    echo -e "${YELLOW}[$(date +'%Y-%m-%d %H:%M:%S')] WARNING: $1${NC}"
}

error() {
    echo -e "${RED}[$(date +'%Y-%m-%d %H:%M:%S')] ERROR: $1${NC}"
    exit 1
}

usage() {
    cat << EOF
Usage: $0 [OPTIONS] PLAYBOOK

Test Ansible playbooks in a containerized environment before running on production.

OPTIONS:
    -h, --help      Show this help message
    -c, --clean     Clean up test container before starting
    -k, --keep      Keep test container running after test
    -t, --tags      Ansible tags to run (comma-separated)
    --check         Run Ansible in check mode (dry run)

EXAMPLES:
    $0 playbooks/vps-bootstrap.yml
    $0 --clean --check playbooks/site.yml
    $0 --tags security,nginx playbooks/site.yml

EOF
}

cleanup() {
    if [[ "${KEEP_CONTAINER:-false}" != "true" ]]; then
        log "Cleaning up test container..."
        cd "$COMPOSE_DIR"
        podman-compose -f ansible-test.yml down || true
    else
        log "Keeping test container running (use --clean to remove)"
    fi
}

# Parse command line arguments
PLAYBOOK=""
CLEAN=false
KEEP_CONTAINER=false
ANSIBLE_TAGS=""
CHECK_MODE=""

while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            usage
            exit 0
            ;;
        -c|--clean)
            CLEAN=true
            shift
            ;;
        -k|--keep)
            KEEP_CONTAINER=true
            shift
            ;;
        -t|--tags)
            ANSIBLE_TAGS="--tags $2"
            shift 2
            ;;
        --check)
            CHECK_MODE="--check"
            shift
            ;;
        -*)
            error "Unknown option: $1"
            ;;
        *)
            if [[ -z "$PLAYBOOK" ]]; then
                PLAYBOOK="$1"
            else
                error "Multiple playbooks specified. Use one at a time."
            fi
            shift
            ;;
    esac
done

if [[ -z "$PLAYBOOK" ]]; then
    error "No playbook specified. Use --help for usage information."
fi

# Validate playbook exists
if [[ ! -f "$ANSIBLE_DIR/$PLAYBOOK" ]]; then
    error "Playbook not found: $ANSIBLE_DIR/$PLAYBOOK"
fi

# Set up trap for cleanup
trap cleanup EXIT

log "Starting Ansible playbook test for: $PLAYBOOK"

# Clean up existing container if requested
if [[ "$CLEAN" == "true" ]]; then
    log "Cleaning up existing test container..."
    cd "$COMPOSE_DIR"
    podman-compose -f ansible-test.yml down || true
fi

# Start test container
log "Starting test container..."
cd "$COMPOSE_DIR"
podman-compose -f ansible-test.yml up -d

# Wait for container to be ready
log "Waiting for container to be ready..."
sleep 5

# Install Python, sudo, systemd, and locales in the container
log "Installing Python, sudo, systemd, and locales in test container..."
podman exec ansible-test bash -c "apt update && apt install -y python3 sudo systemd procps locales" || error "Failed to install dependencies in container"

# Set up passwordless sudo for testing
log "Configuring passwordless sudo in test container..."
podman exec ansible-test bash -c "echo 'root ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/test-env" || warn "Failed to configure passwordless sudo"

# Start systemd in the background
log "Starting systemd in container..."
podman exec -d ansible-test bash -c "/lib/systemd/systemd --system" || warn "Systemd may not be available in container"

# Run the Ansible playbook
log "Running Ansible playbook: $PLAYBOOK"
cd "$ANSIBLE_DIR"

# Build ansible-playbook command (no become password needed in container)
ANSIBLE_CMD="ansible-playbook -i $PROJECT_ROOT/infrastructure/containers/compose/test-inventory $PLAYBOOK $ANSIBLE_TAGS $CHECK_MODE"

log "Executing: $ANSIBLE_CMD"
eval "$ANSIBLE_CMD" || error "Ansible playbook failed"

log "Ansible playbook test completed successfully!"

if [[ "$KEEP_CONTAINER" == "true" ]]; then
    log "Test container is still running. Connect with: podman exec -it ansible-test bash"
fi