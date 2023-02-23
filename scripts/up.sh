#!/usr/bin/env bash
set -e

cd "$(dirname "$0")/../"

if [ ! -f "/var/lib/libvirt/images/fedora37.qcow2" ]; then
    sudo cp qcow2-images/fedora37.qcow2 /var/lib/libvirt/images/fedora37.qcow2
fi

LANG=C

virt-install \
    --name fedora37 \
    --import \
    --memory 4000 \
    --disk /var/lib/libvirt/images/fedora37.qcow2 \
    --osinfo fedora37 \
    --graphics spice,gl.enable=yes,listen=none \
    --video virtio \
    --noautoconsole
