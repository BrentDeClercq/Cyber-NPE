#!/usr/bin/env bash 

# Vars
VM_NAME="Debian-Cyber-NPE"
USERNAME="osboxes"
PASSWORD="osboxes.org"

# Delete existing VM
VBoxManage controlvm $VM_NAME poweroff
VBoxManage unregistervm $VM_NAME --delete

# Copy vdi file
cp ./debian/server.vdi ./osboxes.vdi


# Create VM
VBoxManage createvm --name "$VM_NAME" --ostype "Debian_64" --register
VBoxManage storagectl "$VM_NAME" --name "SATA Controller" --add sata --controller IntelAhci
VBoxManage storageattach "$VM_NAME" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium osboxes.vdi
VBoxManage modifyvm "$VM_NAME" --memory 1024 --vram 128
VBoxManage modifyvm "$VM_NAME" --nic1 nat
VBoxManage modifyvm "$VM_NAME" --nic2 hostonly --hostonlyadapter2 vboxnet1
VBoxManage modifyvm "$VM_NAME" --boot1 dvd --boot2 disk --boot3 none --boot4 none

# Start VM
VBoxManage startvm "$VM_NAME" --type headless

# Copy script to VM

VBoxManage guestcontrol "$VM_NAME" copyto --target-directory=/home/osboxes/ --username=$USERNAME --password=$PASSWORD install.sh


# sshpass -p 'osboxes.org' ssh osboxes@$VM_IP "bash -s" < install.sh    