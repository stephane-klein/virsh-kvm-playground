#!/usr/bin/env bash
set -e

cd "$(dirname "$0")/../"

# This script come from https://github.com/tusqasi/scripts/blob/master/run_ex_vm
ip=$(virsh net-dhcp-leases default |grep " fedora37 "|awk '{print $(NF-2)}'|cut -d'/' -f1)
echo $ip

ssh vagrant@${ip}
