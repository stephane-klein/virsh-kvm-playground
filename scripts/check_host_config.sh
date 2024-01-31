#!/usr/bin/env bash
set -e

cd "$(dirname "$0")/../"

LANG=C

# This instruction come from: https://wiki.archlinux.org/title/KVM
lscpu | grep Virtualization
lsmod | grep kvm
