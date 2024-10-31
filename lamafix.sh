#!/bin/bash

# Securely upgrade pip, setuptools, and wheel
echo "Upgrading pip, setuptools, and wheel..."
pip install --upgrade pip setuptools wheel || { echo "Failed to upgrade pip, setuptools, or wheel"; exit 1; }

# Display OS information securely
echo "Displaying OS information..."
if [ -f /etc/os-release ]; then
    cat /etc/os-release || { echo "Failed to display OS release information"; exit 1; }
else
    echo "/etc/os-release file not found!"
fi

# Install Development Tools group securely with error handling
echo "Installing Development Tools..."
sudo dnf groupinstall "Development Tools" -y || { echo "Failed to install Development Tools"; exit 1; }

# Install necessary libraries securely with error handling
echo "Installing python3-devel, libffi-devel, and openssl-devel..."
sudo dnf install python3-devel libffi-devel openssl-devel -y || { echo "Failed to install required libraries"; exit 1; }

# Install pynacl with pip securely
echo "Installing pynacl..."
pip install pynacl || { echo "Failed to install pynacl"; exit 1; }

# Re-upgrade pip as the last step if required
echo "Upgrading pip again if needed..."
pip install --upgrade pip || { echo "Failed to upgrade pip"; exit 1; }

echo "All installations and upgrades completed successfully!"
