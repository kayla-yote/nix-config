{ config, pkgs, lib, ... }: {
   networking.hostName = lib.mkDefault "rasa";

   environment.variables.EDITOR = "vim";
   security.sudo.wheelNeedsPassword = false;

   #time.timeZone = "America/Los_Angeles";
   services.tzupdate.enable = true;

   # -

   imports = [
   ];

   # -
   # Firewall

   #networking.firewall.enable = false;
   networking.firewall.allowedTCPPorts = [
      80
      8000
   ];
   #networking.firewall.allowedUDPPorts = [ ... ];
   #networking.nftables.enable = true;

   # -
   # Users. (Don't forget to set a password with ‘passwd’)
   users.groups.ssh = {};

   users.users.kilo = {
      isNormalUser = true;
      description = "Kaela";
      extraGroups = [
         "dialout" # Embedded dev, talk to e.g. Arduino
         "networkmanager"
         "ssh"
         "wheel"
      ];
      openssh.authorizedKeys.keyFiles = [
         ./kayla-2023.pub
      ];
      packages = with pkgs; [
      ];
   };

   # -

   programs.command-not-found.enable = true;
   
   # Allow unfree packages
   nixpkgs.config.allowUnfree = true;
   nix.settings.experimental-features = [ "nix-command" "flakes" ];

   # List packages installed in system profile. To search, run:
   # $ nix search wget
   environment.systemPackages = with pkgs; [
      vim-full
      wget
      git
      python313
      python313Packages.pip
      wirelesstools
      wl-clipboard
      atop
      powertop
      ethtool
      progress
      pv
   ];

   # Services

   # -
   # SSHD

   # services.openssh.enable = true;
   services.openssh = {
      enable = true;
      authorizedKeysInHomedir = false;
      settings = {
         #LogLevel = "DEBUG3";
         PasswordAuthentication = false;
         KbdInteractiveAuthentication = false;
         PermitRootLogin = "no";
         AllowGroups = [ "ssh" ];
      };
      #allowSFTP = false;
   };

   # -
   # MDNS

   services.avahi = {
      enable = true;
      nssmdns4 = true;
      nssmdns6 = true;
      openFirewall = true;
      publish = {
         enable = true;
         addresses = true;
         domain = true;
      };
   };
   
   # -
   # LAN/Wifi

   networking = {
      networkmanager = {
         enable = true;
         # Can help with faster reconnection:
         wifi.scanRandMacAddress = false;
         #wifi.powersave = false;
         insertNameservers = [
            "1.1.1.1"
            "8.8.8.8"
         ];
      };
      wireless = { # wpa_supplicant
         fallbackToWPA2 = false;
      };
   };
   
   # -

   # Select internationalisation properties.
   i18n.defaultLocale = "en_US.UTF-8";
   i18n.extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
   };
}
