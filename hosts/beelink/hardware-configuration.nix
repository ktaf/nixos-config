#
# Hardware settings for my Beelink EQ12 Pro Mini PC
#
# flake.nix
#  └─ ./hosts
#      └─ ./beelink
#          ├─ default.nix
#          └─ hardware-configuration.nix *
#
# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
#

{ config, lib, pkgs, modulesPath, host, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/045641c5-b7de-468b-979f-565b1ee56803";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/94BB-A907";
      fsType = "vfat";
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/cb9fb859-74ce-4010-a9b3-0d16c6df9831";
      fsType = "ext4";
    };

  swapDevices = [ ];

  fileSystems."/storage" =
    {
      device = "//192.168.0.3/storage";
      fsType = "cifs";
      options = let
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
      in ["${automount_opts},mfsymlinks,uid=1000,gid=100,credentials=/home/matthias/smb"];
    };

  fileSystems."/media" =
    {
      device = "//192.168.0.3/media";
      fsType = "cifs";
      options = let
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
      in ["${automount_opts},mfsymlinks,uid=1000,gid=100,credentials=/home/matthias/smb"];
    };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  networking = with host; {
    useDHCP = true;
    hostName = hostName;
    bridges = {
      "br0" = {
        interfaces = [ "enp1s0" ];
      };
    };
    interfaces = {
      #enp1s0 = {
      #  useDHCP = false;
      #  ipv4.addresses = [{
      #    address = "192.168.0.50";
      #    prefixLength = 24;
      #  }];
      #};
      #enp2s0.useDHCP = true;
      #wlo1.useDHCP = true;
      br0 = {
        useDHCP = false;
        ipv4.addresses = [{
          address = "192.168.0.50";
          prefixLength = 24;
        }];
      };
    };
    enableIPv6 = false;
    defaultGateway = "192.168.0.1";
    nameservers = [ "192.168.0.4" "1.1.1.1"];   # Pi-Hole DNS
  };
}
