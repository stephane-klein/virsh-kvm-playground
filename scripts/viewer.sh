#!/usr/bin/env bash
set -e

cd "$(dirname "$0")/../"

virt-viewer -a -- fedora37
