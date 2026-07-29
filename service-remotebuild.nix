{
  # Emulate for cross-compiles
  boot.binfmt.emulatedSystems = [
    #"aarch64-linux"
  ];

  users.users.remotebuild = {
    isSystemUser = true;
    group = "remotebuild";
    extraGroups = [
      "ssh"
    ];
    useDefaultShell = true;
    openssh.authorizedKeys.keyFiles = [
      ./kayla-2023.pub
    ];
  };
  users.groups.remotebuild = {};

  nix.settings.trusted-users = [ "remotebuild" ];
}
