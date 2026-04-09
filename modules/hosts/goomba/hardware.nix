{ self, inputs, ...}: {
  flake.nixosModules.goombaHardware = { config, lib, pkgs, modulesPath, ... }: {

    imports =
      [ (modulesPath + "/installer/scan/not-detected.nix")
      ];

    boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "uas" "sd_mod" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-intel" ];
    boot.extraModulePackages = [ ];

    fileSystems."/" =
      { device = "/dev/disk/by-uuid/c503d8d0-e083-43f7-9cf6-d0d79fc103cb";
        fsType = "ext4";
      };

    fileSystems."/boot" =
      { device = "/dev/disk/by-uuid/39D8-9696";
        fsType = "vfat";
        options = [ "fmask=0077" "dmask=0077" ];
      };

    swapDevices =
      [ { device = "/dev/disk/by-uuid/fdea71a3-139c-421f-b254-391014f633f7"; }
      ];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
};
}
