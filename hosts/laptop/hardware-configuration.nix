#
# Hardware settings for HP ProBook 650 G1 15.6" Laptop
# Dual boot active. Windows @ sda4 / NixOS @ sda5
#
# flake.nix
#  └─ ./hosts
#      └─ ./laptop
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

  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/6E06-6221";
      fsType = "vfat";
    };

  swapDevices = [ ];
  
  networking = with host; {
    useDHCP = false;                        # Deprecated
    hostName = hostName;
    networkmanager.enable = true;
    interfaces = {
      enp0s25 = {
        useDHCP = true;                     # For versatility sake, manually edit IP on nm-applet.
        #ipv4.addresses = [ {
        #    address = "192.168.0.51";
        #    prefixLength = 24;
        #} ];
      };
      wlo1 = {
        useDHCP = true;
        #ipv4.addresses = [ {
        #  address = "192.168.0.51";
        #  prefixLength = 24;
        #} ];  
      };
    };
    defaultGateway = "192.168.0.1";
    nameservers = [ "192.168.0.4" ];
    firewall = {
      enable = false;
      #allowedUDPPorts = [ 53 67 ];
      #allowedTCPPorts = [ 53 80 443 9443 ];
    };
  };

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
