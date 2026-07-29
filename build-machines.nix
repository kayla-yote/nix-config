{ pkgs, ... }: {
   nix.distributedBuilds = true;
   nix.settings.builders-use-substitutes = true;

   nix.buildMachines = [
      {
         hostName = "thoth.local";
         sshUser = "remotebuild";
         sshKey = "/home/kilo/.ssh/kayla-2023.priv";
         system = pkgs.stdenv.hostPlatform.system;
         supportedFeatures = [
            "nixos-test"
            "big-parallel"
            "kvm"
         ];
      }
   ];
}
