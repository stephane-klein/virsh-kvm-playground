# virsh + kvm playground

This playground was written to execute Fedora 39 guest on Fedora 39 host.

## Introduction

I've been using Vagrant coupled with Virtualbox since 2012, it's done me great service, it's software I enjoy.

In early 2023, I can't remember exactly why (I didn't take notes 🙁 ) I had trouble using Vagrant on Linux.  
Following this, I was curious to know, if on a Linux host, if I could reproduce the same workflow as Vagrant but based only on some bash and qemu / kvm scripts.
For me, the Vagrant workflow is as follows:

- a command to download OS image
- a command to start VM instance
- a command to enter in VM instance with ssh
- a command to destroy the VM instance

After completing this playground, I think I've succeeded.

## The stack

In this playground, I use:

- qemu
- kvm
- libvirt

Qemu [`virtio-gpu`](https://www.qemu.org/docs/master/system/devices/virtio-gpu.html) device is enabled to paravirtualizes the GPU and display controller.  

This element is important to me, because I want to use what I've built in this playground to create a script that configures my Linux desktop environment from a to z.  
That is, :
- instantiate a new VM
- [launch this command](https://github.com/stephane-klein/dotfiles/blob/d7a8d576121564ed5ac5d1885e7dae1e943a9b4c/README.md?plain=1#L221):
  ```
  $ sh -c "$(curl -fsLS chezmoi.io/get)" -- init --apply stephane-klein
  ```

## Getting started

First, I check whether kvm support is enabled on my OS:

```sh
$ ./scripts/check_host_config.sh
Virtualization:                     AMD-V
kvm_amd               204800  0
kvm                  1372160  1 kvm_amd
irqbypass              12288  1 kvm
ccp                   155648  1 kvm_amd
```

Next, I install dependencies:

```sh
$ sudo dnf group install --with-optional virtualization
$ sudo dnf install bridge-utils
$ sudo usermod -a -G libvirt stephane
$ sudo usermod -a -G qemu stephane
$ sudo systemctl enable libvirtd
$ sudo systemctl start libvirtd
```

I configure libvirt.

Configure `virsh` default uri:

```sh
$ mkdir -p  ~/.config/libvirt/
$ cat <<EOF > ~/.config/libvirt/libvirt.conf
uri_default = "qemu:///system"
EOF
```

Configure *virt-manager* Grab keys to `Ctrl-R`:

```
$ dconf read /org/virt-manager/virt-manager/console/grab-keys
```

Download Fedora39 `qcow2` from [generic/fedora39 Vagrant box](https://app.vagrantup.com/generic/boxes/fedora39) to `qcow2-images/fedora39.qcow2`:

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

---

```sh
$ qemu-system-x86_64 \
    -machine pc \
    -enable-kvm \
    -k fr \
    -device e1000,netdev=net0 \
    -netdev user,id=net0,hostfwd=tcp::5555-:22 \
    -hda qcow2-images/fedora39.qcow2 \
    -display sdl \
    -m 4096
```
Cette configuration fonctionne bien :

```
$ qemu-system-x86_64 \
    -machine pc \
    -enable-kvm \
    -k fr \
    -device e1000,netdev=net0 \
    -netdev user,id=net0,hostfwd=tcp::5555-:22 \
    -hda qcow2-images/fedora39.qcow2 \
    -display sdl,gl=on,show-cursor=off,grab-mod=rctrl \
    -m 8096 \
    -device virtio-vga-gl
```

Toggle full screen:

- On Qwerty: `rctlr-f`
- On Azerty: `rctlr-f`
- On Bépo: `rctlr-e`

Enter in VM via SSH:
```
$ ssh -o "UserKnownHostsFile=/dev/null" -o "StrictHostKeyChecking=no" vagrant@localhost -p 5555
```

Default password: `vagrant`.

```
$ sudo su
# localectl set-keymap fr-bepo
# dnf update -y
# dnf install waybar hyprland
# reboot

```

## Ressources

This playground is mainly based on the [Getting started with virtualization](https://docs.fedoraproject.org/en-US/quick-docs/getting-started-with-virtualization/) documentation.

