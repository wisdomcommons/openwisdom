#!/bin/bash
set -euo pipefail

echo "Installing Open Wisdom development dependencies..."

# Detect OS
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux (Debian/Ubuntu)
    echo "Detected Linux - installing with apt..."
    sudo apt update
    
    # Install Ansible
    sudo apt install -y ansible
    
    # Install Podman
    sudo apt install -y podman podman-compose
    
    # Install OpenTofu
    curl --proto '=https' --tlsv1.2 -fsSL https://get.opentofu.org/install-opentofu.sh | sh
    
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    echo "Detected macOS - installing with Homebrew..."
    
    # Check if Homebrew is installed
    if ! command -v brew &> /dev/null; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    
    # Install dependencies
    brew install ansible podman opentofu
    
else
    echo "Unsupported operating system: $OSTYPE"
    exit 1
fi

echo "Dependencies installed successfully!"
echo "Verifying installations..."

# Verify installations
ansible --version
podman --version  
tofu version

echo "All dependencies verified. Ready for development!"
