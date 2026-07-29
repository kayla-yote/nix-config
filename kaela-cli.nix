{ config, pkgs, lib, ... }: {
   imports = [
      ./kaela-base.nix
      ./build-machines.nix
      ./service-remotebuild.nix
      (fetchTarball "https://github.com/nix-community/nixos-vscode-server/tarball/master")
   ];
   
   # Emulate for cross-compiles
   boot.binfmt.emulatedSystems = [
      #"aarch64-linux"
   ];

   # Add uinput privs to group "input".
   services.udev.extraRules = ''
      KERNEL=="uinput", GROUP="input", MODE="0660", OPTIONS+="static_node=uinput"
   '';
   
   # -

   # Packages used on cli, but not critical. (e.g. gcc, but not vim)
   # To search, run:
   # $ nix search wget
   environment.systemPackages = with pkgs; [
      #gearlever
      nodejs
      cargo
      rustc
      gcc
      gnumake
      gdb
   ];

   # Services

   services.vscode-server.enable = true;

   # -
   # Bluetooth

   hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
         General = {
            # Shows battery charge of connected devices on supported
            # Bluetooth adapters. Defaults to 'false'.
            Experimental = true;
            # When enabled other devices can connect faster to us, however
            # the tradeoff is increased power consumption. Defaults to
            # 'false'.
            #FastConnectable = true;
         };
         Policy = {
            # Enable all controllers when they are found. This includes
            # adapters present on start as well as adapters that are plugged
            # in later on. Defaults to 'true'.
            #AutoEnable = true;
         };
      };
   };
}
