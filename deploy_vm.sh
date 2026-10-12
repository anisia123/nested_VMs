#!/bin/bash

# Configuratie
VM_NAME=$1
PARENT_DISK="/var/lib/libvirt/images/master-mini.qcow2" # Imaginea Master din interiorul VM1
NEW_DISK="/var/lib/libvirt/images/${VM_NAME}.qcow2" # Imaginea noii masini virt create
if [ -z "$VM_NAME" ]; then
    echo "Utilizare: ./deploy_vm.sh <nume_vm_nou>"
    exit 1
fi

echo "--- Incepem deploy-ul pentru $VM_NAME ---"

# Crearea discului folosind Linked Clone (Backing File) [cite: 25, 27]
echo "Generare disc nou..."
sudo qemu-img create -f qcow2 -b "$PARENT_DISK" -F qcow2 "$NEW_DISK"
# [ADD THIS NEW SECTION] -------------------------
echo "Curatare identitate (Sysprep)..."
# We act on the disk file directly because the VM isn't registered yet
sudo virt-sysprep -a "$NEW_DISK" --hostname "$VM_NAME" --operations machine-id,defaults
# ------------------------------------------------
# Pornirea noii instante folosind virt-install [cite: 29]
# Activam host-passthrough pentru a permite recursivitatea in continuare [cite: 12]
echo "Lansare masina virtuala..."
sudo virt-install \
--name "$VM_NAME" \
--memory 2048 \
--vcpus 1 \
--disk "$NEW_DISK" \
--import \
--os-variant ubuntu24.04 \
--cpu host-passthrough \
--network network=default \
--noautoconsole

echo "--- Deploy finalizat pentru $VM_NAME ---"
