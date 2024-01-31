#!/usr/bin/env bash
set -e

cd "$(dirname "$0")/../"

mkdir -p qcow2-images
curl -L --progress-bar \
    -o qcow2-images/fedora39.box \
    https://app.vagrantup.com/generic/boxes/fedora39/versions/4.3.12/providers/qemu/arm64/vagrant.box

tar xvf qcow2-images/fedora39.box -C qcow2-images box_0.img
mv qcow2-images/box_0.img qcow2-images/fedora39.qcow2

rm qcow2-images/fedora39.box
