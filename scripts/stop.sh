#!/usr/bin/env bash
set -e

cd "$(dirname "$0")/../"

virsh shutdown fedora37
