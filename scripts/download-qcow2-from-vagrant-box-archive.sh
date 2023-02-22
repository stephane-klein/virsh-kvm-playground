#!/usr/bin/env bash
set -e

cd "$(dirname "$0")/../"

mkdir -p qcow2-images
curl -L --progress-bar \
    -o qcow2-images/fedora37.box \
    https://app.vagrantup.com/generic/boxes/fedora37/versions/4.2.14/providers/libvirt.box

tar xvf qcow2-images/fedora37.box -C qcow2-images box.img
mv qcow2-images/box.img qcow2-images/fedora37.qcow2

rm qcow2-images/fedora37.box
