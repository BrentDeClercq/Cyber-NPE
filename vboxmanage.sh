#!/bin/bash

# Vars
VM_NAME="Debian-Cyber-NPE"
VM_IP=192.168.53.100

# Create VM
VBoxManage createvm --name "$VM_NAME" --ostype "Debian_64" --register
VBoxManage storagectl "$VM_NAME" --name "SATA Controller" --add sata --controller IntelAhci
VBoxManage storageattach "$VM_NAME" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium ./osboxes.vdi
VBoxManage modifyvm "$VM_NAME" --memory 1024 --vram 128
VBoxManage modifyvm "$VM_NAME" --nic1 nat
VBoxManage modifyvm "$VM_NAME" --nic2 intnet --intnet2 "cyber-npe"
VBoxManage modifyvm "$VM_NAME" --boot1 dvd --boot2 disk --boot3 none --boot4 none

# Set IP address on internal network
VBoxManage guestproperty set "$VM_NAME" "/VirtualBox/GuestInfo/Net/1/V4/IP" "$VM_IP"

# Start VM
VBoxManage startvm "$VM_NAME" --type headless

ssh username@$VM_IP "bash -s" < install.sh