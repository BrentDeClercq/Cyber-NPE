#!/bin/bash

# Vars
VM_NAME="Debian-Cyber-NPE"


VBoxManage createvm --name "$VM_NAME" --ostype "Debian_64" --register
VBoxManage storagectl "$VM_NAME" --name "SATA Controller" --add sata --controller IntelAhci
VBoxManage storageattach "$VM_NAME" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium ./osboxes.vdi
VBoxManage modifyvm "$VM_NAME" --memory 1024 --vram 128
VBoxManage modifyvm "$VM_NAME" --nic1 nat
VBoxManage modifyvm "$VM_NAME" --nic2 intnet --intnet2 "cyber-npe"
VBoxManage modifyvm "$VM_NAME" --boot1 dvd --boot2 disk --boot3 none --boot4 none
VBoxManage startvm "$VM_NAME" --type headless

