#!/bin/bash

# Create user rushi
useradd -m rushi

# Set password (method 1: echo + passwd for Amazon Linux / CentOS)
echo "rushi:Rushi@123" | chpasswd 2>/dev/null

# Fallback method if chpasswd is not available
if [ $? -ne 0 ]; then
  echo "Setting password using passwd command"
  echo -e "Rushi@123\nRushi@123" | passwd rushi
fi

# Add rushi to sudoers with NOPASSWD
echo "rushi ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/rushi
chmod 440 /etc/sudoers.d/rushi

# Enable PasswordAuthentication in sshd_config
sed -i 's/^#PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
if ! grep -q "^PasswordAuthentication" /etc/ssh/sshd_config; then
  echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
fi

# Restart SSH
if command -v systemctl >/dev/null; then
  systemctl restart sshd
else
  service ssh restart
fi
