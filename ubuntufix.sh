#!/bin/bash

echo "Upgrading pip, setuptools, and wheel..."
pip install --upgrade pip setuptools wheel

echo "Installing cffi version 1.15.0..."
pip install cffi==1.15.0

echo "Uninstalling setuptools..."
pip uninstall -y setuptools

echo "Reinstalling setuptools..."
pip install setuptools

echo "Upgrading packaging..."
pip install --upgrade packaging

echo "Upgrading setuptools..."
pip install --upgrade setuptools

echo "Purging pip cache..."
pip cache purge

echo "Reinstalling cffi version 1.15.0..."
pip install cffi==1.15.0

echo "Installing cffi with binary only..."
pip install cffi --only-binary :all:
pip install cffi --only-binary :all:

echo "Done!"
