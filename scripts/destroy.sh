#!/usr/bin/env bash
set -e

cd "$(dirname "$0")/../"

LANG=C

state=$(virsh list --all | grep " fedora37 " | awk '{ print $3}')
if [ "$state" == "running" ]; then
    virsh destroy fedora37
fi

state=$(virsh list --all | grep " fedora37 " | awk '{ print $3}')
if [ "$state" == "shut" ]; then
    virsh undefine fedora37
fi

