# virsh + kvm playground

This playground was written for Fedora (37).

This playground is mainly based on the [Getting started with virtualization](https://docs.fedoraproject.org/en-US/quick-docs/getting-started-with-virtualization/) documentation.

Check host config:

```sh
$ ./scripts/check_host_config.sh
Virtualization:                     AMD-V
kvm_amd               204800  0
kvm                  1372160  1 kvm_amd
irqbypass              12288  1 kvm
ccp                   155648  1 kvm_amd
```


Install dependencies:

```sh
$ sudo dnf group install --with-optional virtualization
$ sudo dnf install bridge-utils
$ sudo usermod -a -G libvirt stephane
$ sudo usermod -a -G qemu stephane
$ sudo systemctl enable libvirtd
$ sudo systemctl start libvirtd
```

Configure `virsh` default uri:

```sh
$ mkdir -p  ~/.config/libvirt/
$ cat <<EOF > ~/.config/libvirt/libvirt.conf
uri_default = "qemu:///system"
EOF
```

Download Fedora37 `qcow2` from [generic/fedora37 Vagrant box](https://app.vagrantup.com/generic/boxes/fedora37) to `qcow2-images/fedora37.qcow2`:

```sh
$ ./download-qcow2-from-vagrant-box.sh
```

```sh
$ ./scripts/up.sh
$ virsh list --all
 Id   Name       State
--------------------------
 1    fedora37   running
```

Enter in VM (password is `vagrant`):

```sh
$ ./scripts/enter.sh
192.168.122.99
The authenticity of host '192.168.122.99 (192.168.122.99)' can't be established.
ED25519 key fingerprint is SHA256:5BmVoQu1ADicFLhZVmDIeg6//vI4SObq/XjLuK6wX00.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '192.168.122.99' (ED25519) to the list of known hosts.
vagrant@192.168.122.99's password:
```

Open UI window:

```sh
$ ./scripts/viewer.sh
```
