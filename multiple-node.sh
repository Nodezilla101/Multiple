#!/bin/bash

# Menampilkan header
echo "======================================"
echo "   Multiple Network Node Installer"
echo "         By Nodezilla101"
echo "======================================"
sleep 2

echo "Starting system update..."
sudo apt update && sudo apt upgrade -y

echo "Checking system architecture..."
ARCH=$(uname -m)
if [[ "$ARCH" == "x86_64" ]]; then
    CLIENT_URL="https://cdn.app.multiple.cc/client/linux/x64/multipleforlinux.tar"
elif [[ "$ARCH" == "aarch64" ]]; then
    CLIENT_URL="https://cdn.app.multiple.cc/client/linux/arm64/multipleforlinux.tar"
else
    echo "Unsupported system architecture: $ARCH"
    exit 1
fi

echo "Downloading the client from $CLIENT_URL..."
wget $CLIENT_URL -O multipleforlinux.tar

echo "Extracting files..."
tar -xvf multipleforlinux.tar

cd multipleforlinux

echo "Granting permissions..."
chmod +x ./multiple-cli
chmod +x ./multiple-node

echo "Adding directory to system PATH..."
echo "PATH=\$PATH:$(pwd)" >> ~/.bash_profile
source ~/.bash_profile

echo "Setting permissions..."
chmod -R 777 $(pwd)

echo "Launching multiple-node..."
nohup ./multiple-node > output.log 2>&1 &

echo "Please enter your Account ID and PIN to bind your account:"
read -p "Account ID: " IDENTIFIER
read -p "Set your PIN: " PIN

echo "Binding account with ID: $IDENTIFIER and PIN: $PIN..."
multiple-cli bind --bandwidth-download 100 --identifier $IDENTIFIER --pin $PIN --storage 200 --bandwidth-upload 100

echo "Installation completed successfully!"
echo "Join Nodzillaz on Telegram: https://t.me/nodezilla101"
echo "Join Nodzillaz on Discord: https://discord.gg/RAEnTZSEVh"
