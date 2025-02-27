#!/bin/bash

# Print the OS details
cat /etc/os-release

# Upgrade Django
pip install --upgrade django

# Upgrade setuptools and virtualenv
pip install --upgrade setuptools virtualenv

# Install a specific version of setuptools
pip install setuptools==58.5.3

# Uninstall virtualenv
pip uninstall -y virtualenv

# Reinstall virtualenv
pip install virtualenv
