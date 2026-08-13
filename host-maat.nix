{ config, pkgs, ... }: {
   networking.hostName = "maat";

   imports = [
      ./tier1-base.nix
   ];
   #nix.distributedBuilds = mkForce false;
   #users.users.remotebuild.enable = false;
   
   assert networking.firewall.allowedTCPPorts ? 80;
   assert networking.firewall.allowedTCPPorts ? 8000;

   environment.systemPackages = with pkgs; [
      # Local-only packages:
      libressl
   ];

   # -

   # Bootloader.  
   boot.loader.systemd-boot.enable = true;
   boot.loader.efi.canTouchEfiVariables = true;
   boot.loader.timeout = 0;
   boot.kernelPackages = pkgs.linuxPackages_latest; # Use latest kernel

   # -
   
   # This value determines the NixOS release from which the default
   # settings for stateful data, like file locations and database versions
   # on your system were taken. It‘s perfectly fine and recommended to leave
   # this value at the release version of the first install of this system.
   # Before changing this value read the documentation for this option
   # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
   system.stateVersion = "25.11"; # Did you read the comment? 
}
