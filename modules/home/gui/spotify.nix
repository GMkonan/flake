{
  pkgs,
  inputs,
  ...
}: let
  # Tokyo Night Storm color palette for base16
  theme = {
    base00 = "24283b"; # Main Background
    base01 = "1f2335"; # Lighter Background (Player, Sidebar)
    base02 = "3b4261"; # Selection Background (Cards, Selected Rows)
    base03 = "444b6a"; # Comments, Disabled text
    base04 = "787c99"; # Dark Foreground (Subtext)
    base05 = "a9b1d6"; # Default Foreground (Text)
    base08 = "f7768e"; # Red (Errors)
    base0B = "9ece6a"; # Green (Active states, Equalizer)
    base0D = "7aa2f7"; # Blue (Highlights, Buttons)
    base0E = "bb9af7"; # Purple (Elevated Highlights)
  };
  spotify-with-spotx = pkgs.spotify.overrideAttrs (oldAttrs: rec {
    buildInputs = oldAttrs.buildInputs or [] ++ [pkgs.unzip pkgs.perl pkgs.zip pkgs.util-linux];
    spotx = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/SpotX-Official/SpotX-Bash/main/spotx.sh";
      sha256 = "sha256-UHNZy3mTHkYXWShLNHJTIwVBEJ8a+K4uP6+T8+x8vJY=";
    };

    postInstall =
      (oldAttrs.postInstall or "")
      + ''
        # SpotX install script
        bash $spotx -h -P $out/share/spotify
      '';
  });
in {
  imports = [
    inputs.spicetify-nix.homeManagerModules.spicetify
  ];
  programs.spicetify = {
    enable = false;
    spotifyPackage = spotify-with-spotx;
    theme = {
      name = "base16";
      src = pkgs.writeTextFile {
        name = "color.ini";
        destination = "/color.ini";
        text = ''
          [base]
          text               = ${theme.base05}
          text               = ${theme.base05}
          subtext            = ${theme.base04}
          main               = ${theme.base00}
          main-elevated      = ${theme.base01}
          highlight          = ${theme.base0D}
          highlight-elevated = ${theme.base0E}
          sidebar            = ${theme.base01}
          player             = ${theme.base01}
          card               = ${theme.base02}
          shadow             = ${theme.base00}
          selected-row       = ${theme.base02}
          button             = ${theme.base0D}
          button-active      = ${theme.base0B}
          button-disabled    = ${theme.base03}
          tab-active         = ${theme.base01}
          notification       = ${theme.base0D}
          notification-error = ${theme.base08}
          equalizer          = ${theme.base0B}
          misc               = ${theme.base02}
        '';
      };
      # Sidebar configuration is incompatible with the default navigation bar
      sidebarConfig = false;
    };
    colorScheme = "base";
  };
}
