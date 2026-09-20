{host, ...}: {
  users.groups.media = {};
  users.users = {
    sonarr.extraGroups = ["media"];
    immich.extraGroups = ["media"];
  };

  fileSystems."/media/data" = {
    device = "/dev/disk/by-uuid/AECEDEC4CEDE83CD";
    fsType = "ntfs-3g";
    options = ["defaults" "nofail" "uid=1000" "gid=991" "umask=002"];
  };
}
