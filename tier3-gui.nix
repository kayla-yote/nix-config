{ config, pkgs, ... }: {
   imports = [
      ./tier2-cli.nix
      (fetchTarball "https://github.com/nix-community/nixos-vscode-server/tarball/master")
   ];

   # -
   
   # Enable the KDE Plasma Desktop Environment.
   services.displayManager.sddm.enable = true;
   services.desktopManager.plasma6.enable = true;

   # -
   # X11

   # Enable the X11 windowing system.
   # You can disable this if you're only using the Wayland session.
   #services.xserver.enable = true;

   # Enable touchpad support (enabled default in most desktopManager).
   # services.xserver.libinput.enable = true;

   # Configure keymap in X11
   services.xserver.xkb = {
      layout = "us";
      variant = "";
   };

   # -
   
   services.libinput.touchpad.naturalScrolling = true;

   # -

   services.flatpak.enable = true;

   hardware.rtl-sdr.enable = true;

   environment.systemPackages = with pkgs; [
      vscode
      telegram-desktop
      discord
      signal-desktop
      obs-studio
      vlc
      gparted
      unityhub
      vrc-get
      alcom
      #plover.dev
      latest.firefox-nightly-bin
      sdrpp
      kicad
      wsjtx
      cura-appimage
      openscad
      vrcx
   ];

   # -
   # Firefox Nightly

   programs.firefox.enable = true;
   programs.steam.enable = true;

   # https://nixos.wiki/wiki/Firefox
   nixpkgs.overlays =
      let
         # Change this to a rev sha to pin
         moz-rev = "master";
         #moz-url = builtins.fetchTarball { url = "https://github.com/mozilla/nixpkgs-mozilla/archive/${moz-rev}.tar.gz";};
         moz-url = "/home/kilo/bin/nixpkgs-mozilla";
         nightlyOverlay = (import "${moz-url}/firefox-overlay.nix");
      in [
         nightlyOverlay
      ];
   #programs.firefox.package = pkgs.latest.firefox-nightly-bin;

   # -

   services.printing = {
      enable = true;
      drivers = [pkgs.brlaser];
   };

   services.pulseaudio.enable = false;
   security.rtkit.enable = true;
   services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      jack.enable = true;
    
      extraConfig.pipewire.adjust-sample-rate = {
         "context.properties" = {
            "default.clock.rate" = 96000;
            #"defautlt.allowed-rates" = [ 192000 48000 44100 ];
            #"default.allowed-rates" = [ 96000 192000 48000 44100 ];
            #"default.clock.quantum" = 32;
            #"default.clock.min-quantum" = 32;
            #"default.clock.max-quantum" = 32;
         };
      }; 

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
   };
}
