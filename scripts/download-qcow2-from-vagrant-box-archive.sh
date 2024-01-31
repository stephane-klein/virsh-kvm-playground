#!/usr/bin/env bash
set -e

cd "$(dirname "$0")/../"

mkdir -p qcow2-images
curl -L --progress-bar \
    -o qcow2-images/fedora39.box \
    https://app.vagrantup.com/generic/boxes/fedora39/versions/4.3.12/providers/qemu/amd64/vagrant.box

tar xvf qcow2-images/fedora39.box -C qcow2-images box.img
mv qcow2-images/box.img qcow2-images/fedora39.qcow2

rm qcow2-images/fedora39.box
