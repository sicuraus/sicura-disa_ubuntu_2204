# frozen_string_literal: true

# Beaker options for the acceptance tests, loaded via BEAKER_OPTIONS_FILE.
#
# The bento/ubuntu-22.04 libvirt box only boots with UEFI (its disk has an EFI
# system partition and no BIOS boot partition), and its Vagrantfile selects
# the `qemu` driver (software emulation) instead of `kvm`.
libvirt = { 'driver' => 'kvm' }

ovmf = [
  '/usr/share/OVMF/OVMF_CODE_4M.fd',   # Debian/Ubuntu (ovmf package)
  '/usr/share/edk2/ovmf/OVMF_CODE.fd', # Fedora/EL (edk2-ovmf package)
].find { |path| File.exist?(path) }

if ovmf
  libvirt['loader'] = ovmf
  # libvirt creates this from the firmware's variable store template.
  libvirt['nvram'] = '/var/lib/libvirt/qemu/nvram/beaker_ubuntu2204_VARS.fd'
end

{ libvirt: libvirt }
