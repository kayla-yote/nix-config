{ config, pkgs, ... }: {
  networking.hostName = "thoth";

  imports = [
    ./hardware-configuration.nix # (generated)
    <nixos-hardware/framework/12-inch/13th-gen-intel>

    ./tier3-gui.nix
  ];
  #nix.distributedBuilds = mkForce false;
  #users.users.remotebuild.enable = false;

  environment.systemPackages = with pkgs; [
    # Local-only packages:
  ];
  
  # -

  # Bootloader.  
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 0;
  boot.kernelPackages = pkgs.linuxPackages_latest; # Use latest kernel
}
