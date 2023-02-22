# virsh + kvm playground

This playground was written for Fedora (37).

This playground is mainly based on the [Getting started with virtualization](https://docs.fedoraproject.org/en-US/quick-docs/getting-started-with-virtualization/) documentation.

Install dependencies:

```sh
$ sudo dnf group install --with-optional virtualization
$ sudo dnf install bridge-utils
$ sudo systemctl enable libvirtd
$ sudo systemctl start libvirtd
```

Download Fedora37 `qcow2` from [generic/fedora37 Vagrant box](https://app.vagrantup.com/generic/boxes/fedora37):

```sh
$ ./download-qcow2-from-vagrant-box.sh
```
